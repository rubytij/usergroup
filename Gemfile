source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'json'
gem 'capistrano'
gem 'haml-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
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
