FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "foo#{n}@example.com"
    end
    password "password"

    factory :admin do
      sequence :email do |n|
        "admin#{n}@example.com"
      end
      admin true
      admin_limited_access false
    end

    factory :limited_access_admin do
      sequence :email do |n|
        "limited_admin#{n}@example.com"
      end
      admin true
      admin_limited_access true
    end
  end
end
