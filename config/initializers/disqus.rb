require 'yaml'
disqus_config = YAML::load_file( Rails.root.join 'config', 'application.yml' )[ Rails.env ]

disqus_config["disqus"].each do |key, value|
  Disqus::defaults[key.to_sym] = value
end