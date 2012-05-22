namespace :config do
  desc 'Generate config files'
  task :generate => [ :vhost ]

  desc 'nginx config file'
  task :vhost do
    require 'erb'

    erb_env = Proc.new do
      @host = Rails.env.development? ? 'www.rt.dev' : 'www.rubytij.org'
      @root = Rails.env.development? ? Rails.root : '/home/deployer/srv/app/usergroup'
      @public = File.join( @root, 'public' )
      @log = "#{ @root }/log"
      binding
    end.call

    file_name   = "vhost.conf"
    config_dir  = "#{ @root }/config/"
    config_file = ERB.new( File.read( "#{ config_dir }_#{ file_name }.erb" ))

    File.open( File.join(config_dir, file_name), 'w' ) do |f|
      f.print config_file.result( erb_env )
    end
  end
end
