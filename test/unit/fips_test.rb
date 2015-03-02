require 'test_helper'

class FipsTest < ActiveSupport::TestCase
  should strip_attribute :fips_code
  should strip_attribute :city
  should strip_attribute :state

  should allow_mass_assignment_of :fips_code
  should allow_mass_assignment_of :city
  should allow_mass_assignment_of :state
end
