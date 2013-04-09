set :user,        'w'
set :application, 'usergroup'
set :deploy_to,   "/home/#{user}/apps/#{application}"
set :deploy_via,  :remote_cache
set :rails_env,   'production'
set :ssh_name,    'www.rubytij.org'

server ssh_name, :app, :web, :db, :primary => true
