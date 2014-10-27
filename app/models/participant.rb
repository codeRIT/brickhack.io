class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :interest, :last_name, :state, :year

  validates_presence_of :first_name, :last_name, :city, :email, :city, :experience, :interest, :state, :year

  validates :email, email: true

  strip_attributes

  def email=(value)
    super value.try(:downcase)
  end
end
