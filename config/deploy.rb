require 'bundler/capistrano'

set :stages,        %w/staging production/
set :default_stage, 'staging'

require 'capistrano/ext/multistage'

set :use_sudo, false

set :scm, :git
set :repository, `git config --get remote.origin.url`.chomp
set :branch, ENV['TAG']

ssh_options[:forward_agent] = true
default_run_options[:pty]   = true

set :keep_releases, 2
set :port, 22

namespace :deploy do
  desc "Tell Passenger to restart the app"
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :config do
    task :generate do
      run "cd #{release_path} && RAILS_ENV=#{ rails_env } bundle exec rake config:generate"
    end
  end
end

before 'deploy:assets:precompile',  'deploy:config:generate'

before 'deploy:restart', 'deploy:create_symlink'
before 'deploy:restart', 'deploy:migrate'

after :deploy, 'deploy:cleanup'
