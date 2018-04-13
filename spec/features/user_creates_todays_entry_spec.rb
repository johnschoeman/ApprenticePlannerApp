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
    visit_new_entry_form_via_nav_bar
    create_entry(entry_params)

    expect(page).to have_goal_summary(goal1)
    expect(page).to have_goal_summary(goal2)
    expect(page).to have_goal_summary(goal3)
    expect(page).to have_content(todays_date)
  end

  scenario "renders error message when entry is invalid" do
    todays_date = Date.today

    sign_in
    visit new_entry_path
    create_entry(date: todays_date)
    visit new_entry_path
    create_entry(date: todays_date)

    error_message = "Date already has an entry"
    expect(page).to have_error_message(error_message)
  end

  scenario "renders error message when goal is invalid" do
    goal_which_is_too_long = "i"*256

    sign_in
    visit new_entry_path
    create_entry(goal1: goal_which_is_too_long)

    error_message = "Description is too long (maximum is 255 characters)"
    expect(page).to have_error_message(error_message)
  end

  def visit_new_entry_form_via_nav_bar
    visit root_url
    click_on "Entries Index"
    expect(page).to have_content("Entries Index Page")
    click_on "New Entry"
    expect(page).to have_content("Create a New Entry")
  end

  def create_entry(date: Date.today, goal1: nil, goal2: nil, goal3: nil)
    fill_in "entry-date", with: date
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
end
