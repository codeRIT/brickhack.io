FactoryGirl.define do
  factory :user do
    email "foo@example.com"
    password "password"

    factory :admin do
      email "admin@example.com"
      admin true
    end
  end
end
