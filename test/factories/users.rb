FactoryGirl.define do
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
      admin_read_only false
    end

    factory :read_only_admin do
      sequence :email do |n|
        "read_only_admin#{n}@example.com"
      end
      admin true
      admin_read_only true
    end
  end
end
