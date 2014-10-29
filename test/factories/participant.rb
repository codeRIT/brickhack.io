# This will guess the User class
FactoryGirl.define do
  factory :participant do
    first_name  "John"
    last_name   "Doe"
    email       "test@example.com"
    city        "MyString"
    state       "MyString"
    experience  "first"
    year        "1"
    interest    "development"
    school_id   "1"
  end
end
