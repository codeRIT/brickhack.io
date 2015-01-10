require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

  should strip_attribute :first_name
  should strip_attribute :last_name
  should strip_attribute :email
  should strip_attribute :city
  should strip_attribute :state

  should allow_value("email@addresse.foo").for(:email)
  should_not allow_value("email@addresse").for(:email)
  should validate_presence_of :email
  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :city
  should validate_presence_of :state
  should validate_presence_of :year
  should validate_presence_of :birthday
  should validate_presence_of :experience
  should validate_presence_of :interest
  should validate_presence_of :shirt_size
  should_not validate_presence_of :dietary_medical_notes
  should_not validate_presence_of :resume
  should_not validate_presence_of :international
  should_not validate_presence_of :portfolio_url
  should_not validate_presence_of :vcs_url

  should allow_mass_assignment_of :first_name
  should allow_mass_assignment_of :last_name
  should allow_mass_assignment_of :email
  should allow_mass_assignment_of :city
  should allow_mass_assignment_of :state
  should allow_mass_assignment_of :year
  should allow_mass_assignment_of :birthday
  should allow_mass_assignment_of :experience
  should allow_mass_assignment_of :interest
  should allow_mass_assignment_of :school_id
  should allow_mass_assignment_of :school_name
  should allow_mass_assignment_of :shirt_size
  should allow_mass_assignment_of :dietary_medical_notes
  should allow_mass_assignment_of :resume
  should allow_mass_assignment_of :delete_resume
  should allow_mass_assignment_of :international
  should allow_mass_assignment_of :portfolio_url
  should allow_mass_assignment_of :vcs_url

  should allow_value("VA").for(:state)
  should allow_value("NY").for(:state)
  should allow_value("PA").for(:state)
  should_not allow_value("ZZ").for(:state)
  should_not allow_value("New York").for(:state)

  should "allow for international locations" do
    p = build(:registration, international: true, city: "Foo", state: "Bar")
    assert p.valid?, "intl. registration should be valid with custom state"
  end

  should allow_value("Design").for(:interest)
  should allow_value("Development").for(:interest)
  should allow_value("Hardware").for(:interest)
  should_not allow_value("foo").for(:interest)

  should allow_value("first").for(:experience)
  should allow_value("experienced").for(:experience)
  should allow_value("expert").for(:experience)
  should_not allow_value("foo").for(:experience)

  should allow_value("hs").for(:year)
  should allow_value("1").for(:year)
  should allow_value("2").for(:year)
  should allow_value("3").for(:year)
  should allow_value("4").for(:year)
  should allow_value("5+").for(:year)
  should_not allow_value(nil).for(:year)
  should_not allow_value("foo").for(:year)

  should allow_value("S").for(:shirt_size)
  should allow_value("M").for(:shirt_size)
  should allow_value("L").for(:shirt_size)
  should allow_value("XL").for(:shirt_size)
  should_not allow_value("foo").for(:shirt_size)

  should have_attached_file(:resume)
  should validate_attachment_content_type(:resume)
                .allowing('application/pdf')
                .rejecting('text/plain', 'image/png', 'image/jpg', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
  should validate_attachment_size(:resume).less_than(2.megabytes)

  should "downcase emails" do
    s = build(:registration, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  should allow_value('foo.com').for(:portfolio_url)
  should allow_value('github.com/foo', 'bitbucket.org/sman591').for(:vcs_url)
  should allow_value('https://github.com/foo', 'https://bitbucket.org/sman591').for(:vcs_url)
  should_not allow_value('http://foo.com', 'https://bar.com').for(:vcs_url)

  context "#school" do
    should "return the current school" do
      school = create(:school, name: "My University")
      registration = create(:registration, school_id: school.reload.id)
      assert_equal "My University", registration.school.name
    end
  end

  context "#full_name" do
    should "concatenate first and last name" do
      registration = create(:registration, first_name: "Foo", last_name: "Bar")
      assert_equal "Foo Bar", registration.full_name
    end
  end

  context "#full_location" do
    should "concatenate city and state with a comma" do
      registration = create(:registration, city: "Foo", state: "AZ")
      assert_equal "Foo, AZ", registration.full_location
    end
  end

  context "#birthday_formatted" do
    should "format the birthday correctly" do
      registration = create(:registration, birthday: Date.new(1995, 1, 5))
      assert_equal "January 5, 1995", registration.birthday_formatted
    end
  end

end
