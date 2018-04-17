require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User completes a goal" do
  scenario "User clicks an uncomplete goal", js: true do
    user = create(:user)
    entry = create(:entry, user: user)
    goal1_description = Faker::Lorem.sentence
    goal1 = create(:goal, entry: entry, description: goal1_description)
    goal2_description = Faker::Lorem.sentence
    goal2 = create(:goal, entry: entry, description: goal2_description)
    goal1_selector = "goal-#{goal1.id}"
    goal2_selector = "#goal-#{goal2.id}"

    visit entry_path(entry, as: user)
    check goal1_selector

    save_and_open_page
  end
end
