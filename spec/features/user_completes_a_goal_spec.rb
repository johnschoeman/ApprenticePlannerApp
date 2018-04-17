require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User completes a goal" do
  scenario "User clicks an uncomplete goal" do
    user = create(:user)
    entry = create(:entry, user: user)
    goal1_description = Faker::Lorem.sentence
    goal1 = create(:goal, entry: entry, description: goal1_description)
    goal2_description = Faker::Lorem.sentence
    create(:goal, entry: entry, description: goal2_description)

    visit entry_path(entry, as: user)
    save_and_open_page
    goal1_selector = "li#goal-#{goal1.id}"
    find(goal1_selector).click
    expect(page).to have_css("#{goal1_selector} + .line-through")
    find(goal1_selector).click
    expect(page).to_not have_css("li#goal1 + .line-through")
  end
end
