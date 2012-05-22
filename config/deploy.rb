require 'bundler/capistrano'

set :application, 'usergroup'
set :user,        'deployer'
set :ssh_name,    'rubytij.org'

set :scm,         :git
set :scm_verbose, true
set :repository,  `git config --get remote.origin.url`.chomp
set :branch,      'master'

set :use_sudo,        false
set :group_writable,  false
set :keep_releases,   2

ssh_options[:forward_agent] = true

set :deploy_to, "/home/#{ user }/srv/app/#{ application }"
set :deploy_via, :remote_cache
set :rails_env, 'production'

role :app,  ssh_name
role :web,  ssh_name
role :db,   ssh_name, :primary => true

namespace :deploy do
  task :config, :roles => :app do
    run "ln -nfs #{ shared_path }/config/database.yml     #{ release_path }/config/database.yml"
    run "ln -nfs #{ shared_path }/config/application.yml  #{ release_path }/config/application.yml"
    run "ln -nfs #{ shared_path }/log                     #{ release_path }/log"
  end

  task :restart, :roles => :app do
    run "touch #{ File.join current_path, 'tmp', 'restart.txt' }"
  end

  task :cold do
    run "mkdir -p #{ deploy_to }/releases"
    run "mkdir -p #{ shared_path }/log"

    update
  end

  task :gems do
    run "ln -nfs #{ shared_path }/bundle  #{ release_path }/vendor/bundle"
  end
end

before 'deploy:restart' do
  run "cd #{ release_path } && bundle exec rake RAILS_ENV=#{ rails_env } config:generate"
end

after   'deploy:update_code', 'deploy:config'
after   'deploy:update',      'deploy:gems'
before  'deploy:restart',     'deploy:migrate'
after   :deploy,              'deploy:cleanup'
