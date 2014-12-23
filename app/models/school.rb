class School < ActiveRecord::Base
  attr_accessible :name, :address, :city, :state

  validates_presence_of :name

  validates_uniqueness_of :name

  strip_attributes

  def full_name
    out = ""
    out << name
    if city.present? || state.present?
      out << " in "
      out << city if city.present?
      out << ", " if city.present? && state.present?
      out << state if state.present?
    end
    out
  end
end
