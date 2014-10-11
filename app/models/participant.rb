class Participant < ActiveRecord::Base
  attr_accessible :city, :email, :experience, :first_name, :interest, :last_name, :state, :year
end
