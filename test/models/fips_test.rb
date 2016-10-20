require 'test_helper'

class FipsTest < ActiveSupport::TestCase
  should strip_attribute :fips_code
  should strip_attribute :city
  should strip_attribute :state
end
