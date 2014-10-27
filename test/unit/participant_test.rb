require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

  should strip_attribute :first_name
  should strip_attribute :last_name
  should strip_attribute :email
  should strip_attribute :city
  should strip_attribute :state
  should strip_attribute :year

  should allow_value("email@addresse.foo").for(:email)
  should_not allow_value("email@addresse").for(:email)
  should validate_presence_of :email
  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :city
  should validate_presence_of :state

  should allow_mass_assignment_of :first_name
  should allow_mass_assignment_of :last_name
  should allow_mass_assignment_of :email
  should allow_mass_assignment_of :city
  should allow_mass_assignment_of :state
  should allow_mass_assignment_of :year

  should "downcase emails" do
    s = build(:participant, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

end
