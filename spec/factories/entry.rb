FactoryBot.define do
  factory :entry do
    date { Time.now }
    user

    trait :with_note do
      transient do
        note_content { Faker::Lorem.sentence }
      end

      after(:create) do |entry, evaluator|
        create(:note, entry: entry, content: evaluator.note_content)
      end
    end

    trait :with_goals do
      transient do
        goals_count 3
      end

      after(:create) do |entry, evaluator|
        create_list(:goal, evaluator.goals_count, entry: entry)
      end
    end
  end
end
