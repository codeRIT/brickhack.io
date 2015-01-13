FactoryGirl.define do
  factory :user do
    email "foo@example.com"
    password "password"

    factory :admin do
      admin true
    end
  end
end
