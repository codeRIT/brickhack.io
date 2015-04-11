require 'test_helper'

class BusListTest < ActiveSupport::TestCase

  should allow_mass_assignment_of :name
  should allow_mass_assignment_of :capacity
  should allow_mass_assignment_of :notes

  should strip_attribute :name
  should strip_attribute :notes

  should validate_presence_of :name
  should validate_uniqueness_of :name

end
