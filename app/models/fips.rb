class Fips < ActiveRecord::Base
  attr_accessible :fips_code, :city, :state

  strip_attributes
end
