require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should "downcase emails" do
    s = build(:user, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  should allow_value("test@example.com").for(:email)
  should_not allow_value("abcd").for(:email)
end
