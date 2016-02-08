class BusList < ActiveRecord::Base
  attr_accessible :name, :capacity, :notes, :needs_bus_captain

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :schools

  strip_attributes

  def full?
    passengers.count >= capacity
  end

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
