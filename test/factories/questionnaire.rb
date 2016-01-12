FactoryGirl.define do
  factory :questionnaire do
    first_name            "John"
    last_name             "Doe"
    phone                 "(123) 456-7890"
    international         false
    date_of_birth         Date.today - 20.years
    experience            "first"
    school_id             { create(:school).id }
    shirt_size            "Unisex - M"
    dietary_restrictions  ""
    special_needs         ""
    agreement_accepted    true
    can_share_resume      true
    gender                "Male"
    major                 "Computer Science"
    graduation            Date.today - 2.years

    association :user
  end
end
