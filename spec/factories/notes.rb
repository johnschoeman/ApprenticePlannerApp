FactoryBot.define do
  factory :note do
    content { Faker::Lorem.paragraph }
    entry
  end
end
