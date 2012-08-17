set :user,        'deployer'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :remote_cache
set :deploy_env,  :production
set :ssh_name,    'rubytij.org'

server ssh_name, :app, :web, :db, :primary => true
