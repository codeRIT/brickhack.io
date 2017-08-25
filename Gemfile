source 'https://rubygems.org'

ruby IO.read(File.expand_path("../.ruby-version", __FILE__)).chomp

gem 'rails', '~> 5.1.0'

gem 'hackathon_manager', '~> 0.2.0'

gem 'puma'
gem 'rails_12factor', group: :production
gem 'test-unit', '~> 3.0'

gem 'rollbar', '~> 2.8'

gem 'httparty'

gem 'dotenv-rails', groups: [:development, :test]

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'
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

gem 'sparkpost_rails'
