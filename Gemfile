source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'mongo', '1.5.2'
gem 'bson', '1.5.2'
gem 'bson_ext', '1.5.2'
gem 'mongo_mapper', '0.11.0'
gem 'devise', '2.0.0'
gem 'omniauth-facebook'
gem 'mm-devise'
gem "cancan"
gem 'mm-multi-parameter-attributes'
gem 'feedzirra'
gem 'nokogiri'
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
    gem "rspec-rails", "~> 2.5.0"
    gem "webrat", "~> 0.7.3"
    gem 'database_cleaner'
end

group :test do  
  gem 'factory_girl_rails', '~> 1.7.0'
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'simplecov', :require => false
end

group :production do
  gem 'thin'
end
