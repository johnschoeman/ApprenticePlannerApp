require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User completes a goal" do
  scenario "User clicks an uncomplete goal", js: true do
    user = create(:user)
    entry = create(:entry, user: user)
    goal1_description = Faker::Lorem.sentence
    # goal1 =
    #   create(:goal, :incomplete, entry: entry, description: goal1_description)
    goal1 = Goal.create(entry: entry, description: goal1_description, completed: false)
    goal2_description = Faker::Lorem.sentence
    # goal2 =
    #   create(:goal, :incomplete, entry: entry, description: goal2_description)
    goal1_selector = "input#goal-#{goal1.id}"
    # goal2_selector = "#goal-#{goal2.id}"

    visit entry_path(entry, as: user)
    find(:css, goal1_selector).set(true)
    save_and_open_page

    visit entry_path(entry)
    save_and_open_page
    expect(page.find(goal1_selector)).to be_checked

  end

  scenario "Goals that are completed show as checked" do
    entry = create(:entry)
    completed_goal = create(:goal, :completed, entry: entry)
    uncompleted_goal = create(:goal, :uncompleted, entry: entry)
    completed_checkbox_selector = "input#goal-#{completed_goal.id}"
    uncompleted_checkbox_selector = "input#goal-#{uncompleted_goal.id}"

    visit entry_path(entry)
    expect(page.find(completed_checkbox_selector)).to be_checked
    expect(page.find(uncompleted_checkbox_selector)).to_not be_checked
  end
end
