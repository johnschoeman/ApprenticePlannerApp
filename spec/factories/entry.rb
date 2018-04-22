FactoryBot.define do
  factory :entry do
    date { Time.now }
    user

    factory :entry_with_goals do
      transient do
        goals_count 3
      end

      after(:create) do |entry, evaluator|
        create_list(:goal, evaluator.goals_count, entry: entry)
      end
    end
  end
end
