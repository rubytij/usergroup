require 'yaml'
config = YAML::load_file( Rails.root.join 'config', 'application.yml' )[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, config["GITHUB_ID"], config["GITHUB_SECRET"], :scope => "user"
end
