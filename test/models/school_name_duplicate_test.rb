require 'test_helper'

class SchoolNameDuplicateTest < ActiveSupport::TestCase
  should belong_to :school
  should validate_uniqueness_of :name
  should strip_attribute :name
end
