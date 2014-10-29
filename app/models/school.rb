class School < ActiveRecord::Base
  attr_accessible :name, :address, :city, :state

  validates_presence_of :name, :city, :state

  validates_uniqueness_of :name

  strip_attributes
end
