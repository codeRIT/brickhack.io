# This will guess the User class
FactoryGirl.define do
  factory :participant do
    first_name  "John"
    last_name   "Doe"
    email       "test@example.com"
    city        "MyString"
    state       "MyString"
    experience  "MyString"
    year        "MyString"
    interest    "development"
  end
end
