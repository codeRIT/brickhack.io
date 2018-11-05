source 'https://rubygems.org'

ruby IO.read(File.expand_path('.ruby-version', __dir__)).chomp

gem 'rails', '~> 5.2.0'
gem 'mysql2', '>= 0.3.18', '< 0.5'

# rubocop:disable Bundler/DuplicatedGem
if ENV['HACKATHON_MANAGER_DEV'] == '1'
  gem 'hackathon_manager', path: '../hackathon_manager'
else
  gem 'hackathon_manager', '~> 0.8.0'
end
# rubocop:enable Bundler/DuplicatedGem

gem 'puma'
gem 'rails_12factor', group: :production
gem 'test-unit', '~> 3.0'

gem 'rollbar', '~> 2.8'
gem 'skylight'

gem 'httparty'

gem 'dotenv-rails', groups: [:development, :test]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'
  gem 'simplecov', require: false
end

group :test do
  gem 'shoulda'
  gem 'minitest-reporters'
  gem 'valid_attribute'
  gem 'factory_bot_rails'
  gem 'codeclimate-test-reporter', '~> 0.6.0', require: nil
  gem 'rails-controller-testing' # Rails 4 fallback
end

gem 'sparkpost_rails'
