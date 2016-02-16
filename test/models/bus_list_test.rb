require 'test_helper'

class BusListTest < ActiveSupport::TestCase

  should allow_mass_assignment_of :name
  should allow_mass_assignment_of :capacity
  should allow_mass_assignment_of :notes
  should allow_mass_assignment_of :needs_bus_captain

  should strip_attribute :name
  should strip_attribute :notes

  should validate_presence_of :name
  should validate_uniqueness_of :name

  should have_many :schools

  context "#passengers" do
    before do
      @bus_list = create(:bus_list)
      @school = create(:school, bus_list_id: @bus_list.id)
    end

    should "return all passengers" do
      questionnaire1 = create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true)
      questionnaire2 = create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true)
      create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: false)
      assert_equal 2, @bus_list.passengers.count
      assert_equal questionnaire1.id, @bus_list.passengers[0].id
      assert_equal questionnaire2.id, @bus_list.passengers[1].id
    end

    should "only return passengers who have RSVP'd" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, title|
        next if status == "rsvp_confirmed"
        create(:questionnaire, acc_status: status, school_id: @school.id, riding_bus: true)
      end
      assert_equal 1, @bus_list.passengers.count
      assert_equal questionnaire1.id, @bus_list.passengers[0].id
    end

    should "not return passengers from another bus" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true)
      school2 = create(:school)
      create(:questionnaire, acc_status: "rsvp_confirmed", school_id: school2.id, riding_bus: true)
      assert_equal 1, @bus_list.passengers.count
      assert_equal questionnaire1.id, @bus_list.passengers[0].id
    end
  end

end
