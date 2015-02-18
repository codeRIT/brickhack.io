FactoryGirl.define do
  factory :user do
    email "foo@example.com"
    password "password"

    factory :admin do
      email "admin@example.com"
      admin true
      admin_read_only false
    end

    factory :read_only_admin do
      email "read_only_admin@example.com"
      admin true
      admin_read_only true
    end
  end
end
