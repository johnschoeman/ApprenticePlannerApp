FactoryBot.define do
  factory :entry do
    date { Time.now }
    user
  end
end
