namespace :config do
  desc 'Generate config files'
  task :generate => [ :vhost, :database, :application, :htaccess ]

  desc 'Create database.yml'
  task :database do
    erb_config :database, :extension => '.yml'
  end

  desc 'Create application.yml'
  task :application do
    erb_config :application, :extension => '.yml'
  end

  desc 'nginx config file'
  task :vhost do
    erb_config :vhost
  end

  desc 'Create apache .htaccess'
  task :htaccess do
    erb_config '.htaccess', :output_dir => Rails.root.join( 'public' ).to_s, :extension => ''
  end

  def erb_config name, opts={}
    require 'erb'

    ext = opts[:extension] || '.conf'

    host = {
      'development' => 'www.rt.dev',
      'production'  => 'www.rubytij.org'
    }[ Rails.env ]

    config_dir = Rails.root.join( 'config' ).to_s
    output_dir = opts[:output_dir] || config_dir

    erb_env   = Proc.new do
      @host   = host
      @root   = Rails.root
      @public = File.join @root, 'public'
      @log    = File.join @root, 'log'

      @subdomain    = @host.split('.').first
      @db_username  = ENV['DATABASE_USERNAME']  || 'postgres'
      @db_password  = ENV['DATABASE_PASSWORD']
      @app_name     = 'rubytij'

      @github_id      = ENV['GITHUB_ID']
      @github_secret  = ENV['GITHUB_SECRET']
      @disqus_account = ENV['DISQUS_ACCOUNT']

      binding
    end.call

    config_file = ERB.new File.read( File.join config_dir, "_#{ name }#{ ext }.erb" )
    File.open File.join( output_dir, "#{ name }#{ ext }" ), 'w' do |f|
      f.print config_file.result( erb_env )
    end
  end
end
