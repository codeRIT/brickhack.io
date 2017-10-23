FactoryBot.define do
  factory :school_name_duplicate do
    sequence :id do |n|
      n
    end
    sequence :name do |n|
      "The University of Rails #{n}"
    end
  end
end
