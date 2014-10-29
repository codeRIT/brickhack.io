require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  should strip_attribute :name
  should strip_attribute :address
  should strip_attribute :city
  should strip_attribute :state

  should validate_presence_of :name
  should validate_presence_of :city
  should validate_presence_of :state

  should allow_mass_assignment_of :name
  should allow_mass_assignment_of :address
  should allow_mass_assignment_of :city
  should allow_mass_assignment_of :state

  should validate_uniqueness_of :name

end
