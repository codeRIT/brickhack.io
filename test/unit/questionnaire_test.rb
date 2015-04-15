require 'test_helper'

class QuestionnaireTest < ActiveSupport::TestCase

  should belong_to :school

  should strip_attribute :first_name
  should strip_attribute :last_name
  should strip_attribute :city
  should strip_attribute :state
  should strip_attribute :acc_status

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
  should_not validate_presence_of :acc_status
  should_not validate_presence_of :acc_status_author_id
  should_not validate_presence_of :acc_status_date
  should_not validate_presence_of :riding_bus

  should allow_mass_assignment_of :first_name
  should allow_mass_assignment_of :last_name
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
  should allow_mass_assignment_of :agreement_accepted
  should allow_mass_assignment_of :bus_captain_interest
  should_not allow_mass_assignment_of :checked_in_by
  should_not allow_mass_assignment_of :checked_in_at
  should_not allow_mass_assignment_of :acc_status
  should_not allow_mass_assignment_of :acc_status_author_id
  should_not allow_mass_assignment_of :acc_status_date
  should_not allow_mass_assignment_of :riding_bus
  should_not allow_mass_assignment_of :is_bus_captain

  should allow_value("VA").for(:state)
  should allow_value("NY").for(:state)
  should allow_value("PA").for(:state)
  should_not allow_value("ZZ").for(:state)
  should_not allow_value("New York").for(:state)

  should "allow for international locations" do
    p = build(:questionnaire, international: true, city: "Foo", state: "Bar")
    assert p.valid?, "intl. questionnaire should be valid with custom state"
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

  should allow_value(true).for(:agreement_accepted)
  should_not allow_value(false).for(:agreement_accepted)

  should allow_value("pending").for(:acc_status)
  should allow_value("accepted").for(:acc_status)
  should allow_value("waitlist").for(:acc_status)
  should allow_value("denied").for(:acc_status)
  should allow_value("late_waitlist").for(:acc_status)
  should allow_value("rsvp_confirmed").for(:acc_status)
  should allow_value("rsvp_denied").for(:acc_status)
  should_not allow_value("foo").for(:acc_status)

  should have_attached_file(:resume)
  should validate_attachment_content_type(:resume)
                .allowing('application/pdf')
                .rejecting('text/plain', 'image/png', 'image/jpg', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
  should validate_attachment_size(:resume).less_than(2.megabytes)

  should allow_value('foo.com').for(:portfolio_url)
  should allow_value('github.com/foo', 'bitbucket.org/sman591').for(:vcs_url)
  should allow_value('https://github.com/foo', 'https://bitbucket.org/sman591').for(:vcs_url)
  should_not allow_value('http://foo.com', 'https://bar.com').for(:vcs_url)

  context "#school" do
    should "return the current school" do
      school = create(:school, name: "My University")
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal "My University", questionnaire.school.name
    end

    should "increment school questionnaire counter on create" do
      school = create(:school)
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal 1, school.reload.questionnaire_count
    end

    should "update school questionnaire counters on update" do
      school1 = create(:school, name: "School 1")
      school2 = create(:school, name: "School 2", id: 2)
      questionnaire = create(:questionnaire, school_id: school1.reload.id)
      questionnaire.school_id = school2.id
      questionnaire.save
      assert_equal 0, school1.reload.questionnaire_count
      assert_equal 1, school2.reload.questionnaire_count
    end

    should "decrement school questionnaire counter on destroy" do
      school = create(:school)
      questionnaire = create(:questionnaire, school_id: school.id)
      assert_equal 1, school.reload.questionnaire_count
      questionnaire.destroy
      assert_equal 0, school.reload.questionnaire_count
    end
  end

  context "#full_name" do
    should "concatenate first and last name" do
      questionnaire = create(:questionnaire, first_name: "Foo", last_name: "Bar")
      assert_equal "Foo Bar", questionnaire.full_name
    end
  end

  context "#full_location" do
    should "concatenate city and state with a comma" do
      questionnaire = create(:questionnaire, city: "Foo", state: "AZ")
      assert_equal "Foo, AZ", questionnaire.full_location
    end
  end

  context "#birthday_formatted" do
    should "format the birthday correctly" do
      questionnaire = create(:questionnaire, birthday: Date.new(1995, 1, 5))
      assert_equal "January 5, 1995", questionnaire.birthday_formatted
    end
  end

  context "#email" do
    should "return the questionnaire's user" do
      questionnaire = create(:questionnaire)
      questionnaire.user.email = "joe.smith@example.com"
      assert_equal "joe.smith@example.com", questionnaire.email
    end
  end

  context "#acc_status_author" do
    should "return nil if no author" do
      questionnaire = create(:questionnaire, acc_status_author_id: nil)
      assert_equal nil, questionnaire.acc_status_author
    end

    should "return the questionnaire's user" do
      user = create(:user, email: "admin@example.com")
      questionnaire = create(:questionnaire, acc_status_author_id: user.id)
      assert_equal "admin@example.com", questionnaire.acc_status_author.email
    end
  end

  context "#can_rsvp?" do
    should "return true for accepted questionnaires" do
      questionnaire = create(:questionnaire, acc_status: "accepted")
      assert questionnaire.can_rsvp?
      questionnaire.acc_status = "rsvp_confirmed"
      assert questionnaire.can_rsvp?
      questionnaire.acc_status = "rsvp_denied"
      assert questionnaire.can_rsvp?
    end

    should "return false for non-accepted questionnaires" do
      questionnaire = create(:questionnaire, acc_status: "denied")
      assert !questionnaire.can_rsvp?
    end
  end

end
