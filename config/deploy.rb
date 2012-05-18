set :application, "user_group"
set :scm, :git
set :repository, `git config --get remote.origin.url`.chomp
set :branch, "master"

set :deploy_to, "/var/www/apps/#{application}"

set :rails_env, ( ENV['RAILS_ENV'] = 'production' )
set :ssh_name, "127.0.0.1"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
