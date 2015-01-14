# This will guess the User class
FactoryGirl.define do
  factory :school do
    id      1
    name    "University of Rails"
    address "123 Fake Street"
    city    "Rochester"
    state   "NY"
    questionnaire_count 0
  end
end
