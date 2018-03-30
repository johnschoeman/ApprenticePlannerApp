require 'rails_helper'
require 'support/features/clearance_helpers'

RSpec.feature "User creates a journal entry" do
  scenario "creates today's entry" do
    goal1 = Faker::Lorem.sentence
    goal2 = Faker::Lorem.sentence
    goal3 = Faker::Lorem.sentence
    todays_date = Date.today

    sign_in
    visit new_entry_path
    fill_in "goal-date", with: todays_date
    fill_in "Goal 1", with: goal1
    fill_in "Goal 2", with: goal2
    fill_in "Goal 3", with: goal3
    click_on "Create Entry"

    expect(page).to have_goal_summary(goal1)
    expect(page).to have_goal_summary(goal2)
    expect(page).to have_goal_summary(goal3)
    expect(page).to have_content(todays_date)
  end
end

def have_goal_summary(goal)
  have_css(".goal-summary", text: goal)
end
