class SchoolNameDuplicate < ApplicationRecord
  validates_uniqueness_of :name

  strip_attributes

  belongs_to :school
end
