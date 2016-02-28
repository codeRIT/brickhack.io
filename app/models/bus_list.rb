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
    Questionnaire.joins(:school).where("schools.bus_list_id = '#{id}' AND acc_status = 'rsvp_confirmed' AND riding_bus = true")
  end

  def captains
    passengers.where(is_bus_captain: true)
  end
end
