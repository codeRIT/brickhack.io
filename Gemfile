source 'https://rubygems.org'

ruby IO.read(File.expand_path("../.ruby-version", __FILE__)).chomp

gem 'rails', '~> 4.2'

gem 'mysql2'

gem 'puma'
gem 'rails_12factor', group: :production
gem 'test-unit', '~> 3.0'

gem 'rollbar', '~> 2.8'
gem 'skylight'

gem 'sidekiq', '< 5'
gem 'sinatra', :require => nil
gem 'sprockets', :require => nil

gem 'devise'
gem 'devise-async'
gem 'omniauth-mlh'

gem 'haml-rails'
gem 'simple_form'
gem 'kaminari'
gem 'ajax-datatables-rails'
gem 'roadie-rails'
gem 'chartkick'
gem 'groupdate'
gem 'font-awesome-rails' # needed for icon helpers
gem 'protected_attributes'

gem 'strip_attributes'
gem 'paperclip-googledrive', :git => 'git://github.com/sman591/paperclip-googledrive/' # issue with file deletion, url, and paperclip version
gem 'paperclip', '~> 4.3' # drops support for Ruby 1.9.3

gem 'email_validator'
gem 'validate_url'

# Previously grouped under assets:
gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'selectize-rails'
gem 'highcharts-rails', '~> 4.1.8'
gem 'uglifier', '>= 1.0.3'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-minitest'
  gem 'guard'
  gem 'simplecov', require: false
end

group :test do
  gem 'shoulda'
  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'valid_attribute'
  gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
end
