require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

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

  should allow_value("VA").for(:state)
  should allow_value("NY").for(:state)
  should allow_value("PA").for(:state)
  should_not allow_value("ZZ").for(:state)
  should_not allow_value("New York").for(:state)

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
    s = build(:participant, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  context "#school" do
    should "return the current school" do
      school = create(:school, name: "My University")
      participant = create(:participant, school_id: school.reload.id)
      assert_equal "My University", participant.school.name
    end
  end

end
