FactoryBot.define do
  factory :goal do
    description { Faker::Lorem.sentence }
    entry
    completed { [true, false].sample }
  end
end
