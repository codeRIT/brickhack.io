class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :interest, :experience, :last_name, :state, :year, :school_id

  validates_presence_of :first_name, :last_name, :city, :email, :city, :state, :year, :school_id

  validates :email, email: true

  strip_attributes

  POSSIBLE_INTERESTS   = %w(design development hardware)
  POSSIBLE_EXPERIENCES = { "This is my first" => "first", "1-10" => "experienced", "10+" => "expert" }
  POSSIBLE_YEARS       = {
    "High School"       => "hs",
    "College 1st Year"  => "1",
    "College 2nd Year"  => "2",
    "College 3rd Year"  => "3",
    "College 4th Year"  => "4",
    "College 5th+ Year" => "5+"
  }

  validates_inclusion_of :interest, :in => POSSIBLE_INTERESTS
  validates_inclusion_of :experience, :in => POSSIBLE_EXPERIENCES.invert
  validates_inclusion_of :year, :in => POSSIBLE_YEARS.invert
  # validates_inclusion_of :school_id, :in => School.select(:id)

  def email=(value)
    super value.try(:downcase)
  end

  def school
    School.find(school_id)
  end
end
