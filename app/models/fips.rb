class Fips < ApplicationRecord
  attr_accessible :fips_code, :city, :state

  strip_attributes
end
