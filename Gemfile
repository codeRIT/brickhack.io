source 'https://rubygems.org'

ruby IO.read(File.expand_path("../.ruby-version", __FILE__)).chomp

gem 'rails', '~> 5.0.0'

gem 'mysql2'

gem 'puma'
gem 'rails_12factor', group: :production
gem 'test-unit', '~> 3.0'

gem 'rollbar', '~> 2.8'
gem 'skylight'

gem 'sidekiq', '< 5'
gem 'sprockets', :require => nil

gem 'devise', '~> 4.2'
gem 'omniauth-mlh'

gem 'paperclip', '~> 5.0.0'

gem 'haml-rails'
gem 'simple_form'
gem 'kaminari'
gem 'ajax-datatables-rails'
gem 'roadie-rails'
gem 'chartkick', '~> 2.1'
gem 'groupdate'
gem 'font-awesome-rails', '~> 4.0' # needed for icon helpers

gem 'strip_attributes'

gem 'validate_url'

# Previously grouped under assets:
gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'selectize-rails'
gem 'highcharts-rails', '~> 4.2.5'
gem 'uglifier', '~> 3.0'

gem 'dotenv-rails', :groups => [:development, :test]

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
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil
  gem 'rails-controller-testing' # Rails 4 fallback
end
