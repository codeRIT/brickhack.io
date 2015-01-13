require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should strip_attribute :email

  should validate_presence_of :email
  should validate_presence_of :password

  should allow_mass_assignment_of :email
  should allow_mass_assignment_of :password
  should allow_mass_assignment_of :remember_me
  should_not allow_mass_assignment_of :admin

  should "downcase emails" do
    s = build(:user, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  should allow_value("test@example.com").for(:email)
  should_not allow_value("abcd").for(:email)
end
