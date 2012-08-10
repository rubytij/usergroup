set :user,        'deployer'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :production
set :ssh_name,    'rubytij.org'

server ssh_name, :app, :web, :db, :primary => true
