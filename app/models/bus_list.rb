class BusList < ActiveRecord::Base
  attr_accessible :name

  def passengers
    passengers = []
    School.where(bus_list_id: id).each do |s|
      Questionnaire.where(riding_bus: true, school_id: s.id, acc_status: "rsvp_confirmed").each do |q|
        passengers << q
      end
    end
    passengers
  end
end
