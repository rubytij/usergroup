set :user,        'deployer'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :remote_cache
set :rails_env,   'staging'
set :ssh_name,    'stage.rubytij.org'

server ssh_name, :app, :web, :db, primary: true
