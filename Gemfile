source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'json'
gem 'capistrano'
gem 'haml-rails'
gem 'system_timer', :platform => :ruby_18
gem 'acl9'
gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git'
gem 'omniauth-github'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'bootstrap-sass'
end

gem 'rspec-rails', :group => [ :test, :development ]
gem 'jquery-rails'

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mocha'
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
