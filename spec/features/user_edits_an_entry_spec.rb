require 'rails_helper'
require 'support/features/clearance_helpers'

RSpec.feature "User edits and entry" do
  scenario "edits an entry" do
    # As a user i log into the app
    # I go to the index page
    # I click on an entry
    # I am taken to the entries show page
    # I click on an edit entry link
    # I am taken to an edit entry page
    # I make some changes
    # I click submit
    # I am taken to the entry show page with the edits shown

    initial_goal1 = build(:goal, description: Faker::Lorem.sentence)
    initial_goal2 = build(:goal, description: Faker::Lorem.sentence)
    initial_goal3 = build(:goal, description: Faker::Lorem.sentence)
    initial_goals = [initial_goal1, initial_goal2, initial_goal3]
    final_goal1 = Faker::Lorem.sentence
    final_goal2 = Faker::Lorem.sentence

    entry_to_edit = create(:entry, goals: initial_goals)
    entry_to_not_edit = create(:entry_with_goals)

    sign_in
    visit entries_path
    click_on "entry-id-#{entry_to_edit.id}"
    expect(page).to have_content("Entry Show Page")
    expect(page).to have_content(entry_to_edit.date)

    click_on "Edit Entry"
    fill_in "Goal 1", with: final_goal1
    fill_in "Goal 2", with: final_goal2
    click_on "Submit Edit Entry"

    expect(page).to have_content(entry_to_edit.date)
    expect(page).to have_goal_summary(final_goal1)
    expect(page).to_not have_goal_summary(initial_goal1)
    expect(page).to have_goal_summary(final_goal2)
    expect(page).to_not have_goal_summary(initial_goal2)
    expect(page).to have_goal_summary(initial_goal3.description)
  end

  scenario "trys to edit an entry with invalid form data" do
    todays_date = Date.today
    tomorrows_date = todays_date.next_day
    user = sign_in #TODO: find a better way to do this
    entry_to_edit = Entry.create(date: tomorrows_date, user: user)
    Entry.create(date: todays_date, user: user)

    visit edit_entry_path(entry_to_edit)
    fill_in "entry-date", with: todays_date
    click_on "Submit Edit Entry"

    expect(page).to have_error_message("Date already has an entry")
  end
end

def have_goal_summary(goal)
  have_css(".goal-summary", text: goal)
end

def have_error_message(message)
  have_css(".flash-error", text: message)
end
