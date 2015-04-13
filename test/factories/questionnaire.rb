FactoryGirl.define do
  factory :questionnaire do
    first_name            "John"
    last_name             "Doe"
    international         false
    city                  "Rochester"
    state                 "NY"
    year                  "1"
    birthday              Date.today - 20.years
    experience            "first"
    interest              "Development"
    school_id             { create(:school).id }
    shirt_size            "M"
    dietary_medical_notes ""
    agreement_accepted    true

    association :user
  end
end
