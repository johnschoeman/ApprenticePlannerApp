FactoryBot.define do
  factory :goal do
    description { Faker::Lorem.sentence }
    entry
    completed false

    trait :completed do
      completed true
    end

    trait :uncompleted do
      completed false
    end

    trait :blank do
      description ""
    end
  end
end
