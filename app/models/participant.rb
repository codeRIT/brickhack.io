class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :last_name, :state, :year
  attr_accessible :birthday, :interest, :experience, :school_id, :school_name
  attr_accessible :shirt_size, :dietary_medical_notes

  validates_presence_of :first_name, :last_name, :city, :email, :city, :state, :year
  validates_presence_of :birthday, :school_id, :interest, :experience, :shirt_size

  validates :email, email: true

  strip_attributes

  POSSIBLE_INTERESTS   = %w(design development hardware)
  POSSIBLE_EXPERIENCES = { "This is my first" => "first", "1-10" => "experienced", "10+" => "expert" }
  POSSIBLE_YEARS       = {
    "High School" => "hs",
    "1st Year"    => "1",
    "2nd Year"    => "2",
    "3rd Year"    => "3",
    "4th Year"    => "4",
    "5th+ Year"   => "5+"
  }
  POSSIBLE_SHIRT_SIZES = %w(S M L XL)

  validates_inclusion_of :interest, in: POSSIBLE_INTERESTS
  validates_inclusion_of :experience, in: POSSIBLE_EXPERIENCES.invert
  validates_inclusion_of :year, in: POSSIBLE_YEARS.invert
  # validates_inclusion_of :school_id, :in => School.select(:id)
  validates_inclusion_of :shirt_size, in: POSSIBLE_SHIRT_SIZES

  def email=(value)
    super value.try(:downcase)
  end

  def school
    School.find(school_id)
  end
end
