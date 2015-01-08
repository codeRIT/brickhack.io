source 'https://rubygems.org'

gem 'rails', '~> 3.2.16'

group :production do
  gem 'mysql2'
end

gem 'rollbar', '~> 1.3.0'

gem 'haml-rails'
gem 'simple_form'

gem 'strip_attributes'
gem 'paperclip-googledrive', git: 'git://github.com/sman591/paperclip-googledrive/' # issue with file deletion status code, PR #8

gem 'email_validator'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'jquery-ui-sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'guard-minitest'

  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'shoulda'
  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'valid_attribute'
  gem 'ruby-prof'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
