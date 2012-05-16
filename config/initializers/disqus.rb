require 'yaml'
disqus_config = YAML::load_file( Rails.root.join 'config', 'disqus.yml' )[ Rails.env ]
disqus_config.each do |key, value|
  Disqus::defaults[key.to_sym] = value
end