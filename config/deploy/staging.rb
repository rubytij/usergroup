set :user,        'deployer'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :staging
set :ssh_name,    'stage.rubytij.org'

server ssh_name, :app, :web, :db, :primary => true
