# This will guess the User class
FactoryGirl.define do
  factory :registration do
    first_name            "John"
    last_name             "Doe"
    email                 "test@example.com"
    international         false
    city                  "Rochester"
    state                 "NY"
    year                  "1"
    birthday              20.years.ago
    experience            "first"
    interest              "Development"
    school_id             "1"
    shirt_size            "M"
    dietary_medical_notes ""
  end
end
