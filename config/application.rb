require_relative 'boot'

# Commenting this out since we don't use a database.
# require 'rails/all'

# Instead, import only the relevant parts of Rails
# See https://github.com/rails/rails/blob/master/railties/lib/rails/all.rb
%w(
  action_controller/railtie
  action_view/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  require railtie
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Brickhack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # Enable the staging environment for skylight
    config.skylight.environments += ["staging"]
  end
end
