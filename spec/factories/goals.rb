FactoryBot.define do
  factory :goal do
    description { Faker::Lorem.sentence }
    entry
  end
end
