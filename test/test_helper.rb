ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "strip_attributes/matchers"
require "minitest/reporters"
require "valid_attribute"
require "factory_girl_rails"
require "paperclip/matchers"
require 'sidekiq/testing'

if defined?(RUBY_ENGINE) && RUBY_ENGINE == "ruby" && RUBY_VERSION >= "1.9"
  module Kernel
    alias :__at_exit :at_exit
    def at_exit(&block)
      __at_exit do
        exit_status = $!.status if $!.is_a?(SystemExit)
        block.call
        exit exit_status if exit_status
      end
    end
  end
end

Minitest::Reporters.use!
FactoryGirl.reload

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class Test::Unit::TestCase
  extend StripAttributes::Matchers
end

class ActiveSupport::TestCase
  include StripAttributes::Matchers
  include ValidAttribute::Method
  include FactoryGirl::Syntax::Methods
  extend Paperclip::Shoulda::Matchers

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end