class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :interest, :experience, :last_name, :state, :year

  validates_presence_of :first_name, :last_name, :city, :email, :city, :state, :year

  validates :email, email: true

  strip_attributes

  POSSIBLE_INTERESTS   = %w(design development hardware)
  POSSIBLE_EXPERIENCES = { "This is my first" => "first", "1-10" => "experienced", "10+" => "expert" }

  validates_inclusion_of :interest, :in => POSSIBLE_INTERESTS
  validates_inclusion_of :experience, :in => POSSIBLE_EXPERIENCES.invert

  def email=(value)
    super value.try(:downcase)
  end
end
