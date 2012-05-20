require 'bundler/capistrano'

set :application, "usergroup"
set :scm, :git
set :repository, `git config --get remote.origin.url`.chomp
set :branch, "master"
set :user, "deployer"
set :ssh_name, "live.rt"
ssh_options[:forward_agent] = true
set :deploy_to, "/home/#{ user }/srv/app/#{application}"
set :deploy_via, :remote_cache
set :rails_env, ( ENV['RAILS_ENV'] = 'production' )

role :app, "live.rt"
role :web, "live.rt"
role :db, "live.rt", :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before 'deploy:restart' do
  run "cd #{release_path} && bundle exec rake RAILS_ENV=#{rails_env} config:generate"
end
before 'deploy:restart', 'deploy:migrate'
after :deploy, 'deploy:cleanup'