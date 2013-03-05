source 'http://rubygems.org'

gem 'rails', '3.2.12'
gem 'mongo', '1.8.2'
gem 'bson', '1.8.2'
gem 'bson_ext', '1.8.2'
gem 'mongo_mapper', github: "alabeduarte/mongomapper"
gem 'devise', '2.0.0'
gem 'omniauth-facebook', '1.2.0'
gem 'mm-devise', '1.3'
gem "cancan", '1.6.7'
gem 'mm-multi-parameter-attributes', '0.2.1'
gem 'feedzirra', '0.0.24'
gem 'nokogiri', '1.5.0'

group :assets do
  gem 'sass-rails', '3.2.4'
  gem 'uglifier', '1.2.3'
  gem 'jasmine-jquery-rails'
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec', '~> 2.11.0'
  gem "rspec-rails", '~> 2.11.0'
  gem 'jasmine'
  gem 'pry'
end

group :test do
  gem 'rspec-instafail'
  gem 'shoulda-matchers', '~> 1.2'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'turn', '0.8.2', :require => false
  gem "webrat", "~> 0.7.3"
  gem 'simplecov', '0.6.1', :require => false
end

group :production do
  gem 'thin'
end
