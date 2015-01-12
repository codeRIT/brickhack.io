require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  test "TRAVIS TEST" do
    assert false
  end

  should strip_attribute :name
  should strip_attribute :address
  should strip_attribute :city
  should strip_attribute :state

  should validate_presence_of :name

  should allow_mass_assignment_of :name
  should allow_mass_assignment_of :address
  should allow_mass_assignment_of :city
  should allow_mass_assignment_of :state

  should validate_uniqueness_of :name

  context "#full_name" do
    should "include only the name if no city or state" do
      @school = build(:school, name: "Foo", city: nil, state: nil)
      assert_equal "Foo", @school.full_name
    end

    should "include only the name and city if no state" do
      @school = build(:school, name: "Foo", city: "Bar", state: nil)
      assert_equal "Foo in Bar", @school.full_name
    end

    should "include only the name and state if no city" do
      @school = build(:school, name: "Foo", city: nil, state: "World")
      assert_equal "Foo in World", @school.full_name
    end

    should "include name, city, and state" do
      @school = build(:school, name: "Foo", city: "Bar", state: "World")
      assert_equal "Foo in Bar, World", @school.full_name
    end
  end

end
