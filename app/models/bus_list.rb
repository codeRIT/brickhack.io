class BusList < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :schools

  strip_attributes

  def full?
    passengers.count >= capacity
  end

  def passengers
    Questionnaire.joins(:school).where("schools.bus_list_id = '#{id}' AND acc_status = 'rsvp_confirmed' AND riding_bus = true").order("schools.name ASC, last_name ASC")
  end

  def checked_in_passengers
    passengers.select(&:checked_in?)
  end

  def captains
    passengers.where(is_bus_captain: true)
  end
end
