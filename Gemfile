source 'https://rubygems.org'

gem 'rails', '~> 4.2'

gem 'mysql2', '~> 0.3.18'

gem 'puma'
gem 'rails_12factor', group: :production
gem 'test-unit', '~> 3.0'

gem 'rollbar', '~> 2.7'
gem 'skylight'

gem 'sidekiq', "~> 4"
gem 'sinatra', :require => nil
gem 'sprockets', :require => nil

gem 'devise'
gem 'devise-async'

gem 'haml-rails'
gem 'simple_form'
gem 'kaminari'
gem 'ajax-datatables-rails'
gem 'roadie-rails'
gem 'chartkick'
gem 'groupdate'
gem 'font-awesome-rails' # needed for icon helpers
gem 'rails-perftest'
gem 'protected_attributes'

gem 'strip_attributes'
gem 'paperclip-googledrive', :git => 'git://github.com/sman591/paperclip-googledrive/' # issue with file deletion, url, and paperclip version
gem "paperclip", "~> 4.3" # drops support for Ruby 1.9.3

gem 'email_validator'
gem 'validate_url'

# Gems used only for assets and not required
# in production environments by default.
#group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

gem 'jquery-rails'
  gem 'jquery-ui-sass-rails'
  gem 'jquery-datatables-rails', '~> 3.3.0'

  gem 'selectize-rails'
  gem 'highcharts-rails', '~> 4.1.8'

  gem 'uglifier', '>= 1.0.3'
#end

group :development do
#  gem 'better_errors'
  gem 'binding_of_caller'
 # gem 'mail_view', '~> 2.0.4'
  gem 'guard-minitest'
  gem 'guard'
  gem 'simplecov', require: false
end

group :test do
  gem 'shoulda'
  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'valid_attribute'
  gem 'ruby-prof'
  gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
end


