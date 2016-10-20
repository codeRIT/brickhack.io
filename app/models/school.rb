class School < ApplicationRecord
  validates_presence_of :name

  validates_uniqueness_of :name

  strip_attributes

  has_many :questionnaires
  belongs_to :bus_list, optional: true

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

  def bus_list
    return unless bus_list_id
    BusList.find(bus_list_id)
  end

  def fips_code
    Fips.where(city: city, state: state).first
  end
end
