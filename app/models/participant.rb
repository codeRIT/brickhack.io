class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :interest, :last_name, :state, :year

  validates_presence_of :first_name, :last_name, :city, :email, :city, :experience, :state, :year

  validates :email, email: true

  strip_attributes

  POSSIBLE_INTERESTS = %w(design development hardware)

  validates_inclusion_of :interest, :in => POSSIBLE_INTERESTS

  def email=(value)
    super value.try(:downcase)
  end
end
