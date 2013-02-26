set :user,        'w'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :remote_cache
set :deploy_env,  :production
set :ssh_name,    '198.211.98.157'

server ssh_name, :app, :web, :db, :primary => true
