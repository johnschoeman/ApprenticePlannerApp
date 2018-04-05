require 'rails_helper'
require 'support/features/clearance_helpers'

RSpec.feature "User creates a journal entry" do
  scenario "creates today's entry" do
    goal1 = Faker::Lorem.sentence
    goal2 = Faker::Lorem.sentence
    goal3 = Faker::Lorem.sentence
    todays_date = Date.today
    entry_params = { date: todays_date, goal1: goal1, goal2: goal2, goal3: goal3 }

    sign_in
    create_entry(entry_params)

    expect(page).to have_goal_summary(goal1)
    expect(page).to have_goal_summary(goal2)
    expect(page).to have_goal_summary(goal3)
    expect(page).to have_content(todays_date)
  end

  scenario "renders error message when validation fails" do
    todays_date = Date.today

    sign_in
    create_entry(date: todays_date)
    create_entry(date: todays_date)

    error_message = "Date already has an entry"
    expect(page).to have_error_message(error_message)
  end
end

def create_entry(date: Date.today, goal1: nil, goal2: nil, goal3: nil)
  visit new_entry_path
  fill_in "goal-date", with: date
  fill_in "Goal 1", with: goal1 || Faker::Lorem.sentence
  fill_in "Goal 2", with: goal2 || Faker::Lorem.sentence
  fill_in "Goal 3", with: goal3 || Faker::Lorem.sentence
  click_on "Create Entry"
end

def have_goal_summary(goal)
  have_css(".goal-summary", text: goal)
end

def have_error_message(message)
  have_css(".flash-error", text: message)
end
