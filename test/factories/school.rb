# This will guess the User class
FactoryGirl.define do
  factory :school do
    sequence :id do |n|
      n
    end
    sequence :name do |n|
      "University of Rails #{n}"
    end
    address "123 Fake Street"
    city    "Rochester"
    state   "NY"
    questionnaire_count 0
  end
end
