require 'test_helper'

class BusListTest < ActiveSupport::TestCase
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
      allowed_ids = [questionnaire1, questionnaire2].map(&:id)
      assert allowed_ids.include? @bus_list.passengers[0].id
      assert allowed_ids.include? @bus_list.passengers[1].id
    end

    should "only return passengers who have RSVP'd" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, _title|
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

  context "#checked_in_passengers" do
    before do
      @bus_list = create(:bus_list)
      @school = create(:school, bus_list_id: @bus_list.id)
    end

    should "be empty if no passengers" do
      assert_equal 0, @bus_list.checked_in_passengers.count
    end

    should "only return passengers who have checked in" do
      create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true, checked_in_at: 2.minutes.ago)
      create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true, checked_in_at: nil)
      assert_equal 2, @bus_list.passengers.count
      assert_equal 1, @bus_list.checked_in_passengers.count
    end
  end

  context "#captians" do
    before do
      @bus_list = create(:bus_list)
      @school = create(:school, bus_list_id: @bus_list.id)
    end

    should "return all captains" do
      create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true)
      create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true)
      questionnaire1 = create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true, is_bus_captain: true)
      questionnaire2 = create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: true, is_bus_captain: true)
      create(:questionnaire, school_id: @school.id, acc_status: "rsvp_confirmed", riding_bus: false)
      assert_equal 2, @bus_list.captains.count
      allowed_ids = [questionnaire1, questionnaire2].map(&:id)
      assert allowed_ids.include? @bus_list.captains[0].id
      assert allowed_ids.include? @bus_list.captains[1].id
    end

    should "only return captains who have RSVP'd" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true, is_bus_captain: true)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, _title|
        next if status == "rsvp_confirmed"
        create(:questionnaire, acc_status: status, school_id: @school.id, riding_bus: true, is_bus_captain: true)
      end
      assert_equal 1, @bus_list.captains.count
      assert_equal questionnaire1.id, @bus_list.captains[0].id
    end

    should "not return captains from another bus" do
      questionnaire1 = create(:questionnaire, acc_status: "rsvp_confirmed", school_id: @school.id, riding_bus: true, is_bus_captain: true)
      school2 = create(:school)
      create(:questionnaire, acc_status: "rsvp_confirmed", school_id: school2.id, riding_bus: true, is_bus_captain: true)
      assert_equal 1, @bus_list.captains.count
      assert_equal questionnaire1.id, @bus_list.captains[0].id
    end
  end
end
