require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User completes a goal" do
  scenario "User clicks an uncomplete goal", js: true do
    user = create(:user)
    entry = create(:entry, user: user)
    goal1_description = Faker::Lorem.sentence
    goal1 = Goal.create(entry: entry,
                        description: goal1_description,
                        completed: false)
    goal2_description = Faker::Lorem.sentence
    goal2 = Goal.create(entry: entry,
                        description: goal2_description,
                        completed: false)
    goal1_selector = "input#goal-#{goal1.id}"
    goal2_selector = "input#goal-#{goal2.id}"

    allow_protect_against_forgery

    visit entry_path(entry, as: user)
    click_checkbox(goal1_selector)
    wait_for_ajax

    visit entry_path(entry)
    expect(page.find(goal1_selector)).to be_checked
    expect(page.find(goal2_selector)).to_not be_checked
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

  def allow_protect_against_forgery
    allow_any_instance_of(ActionController::Base).
      to receive(:protect_against_forgery?).and_return(true)
  end

  def click_checkbox(checkbox_selector)
    find(:css, checkbox_selector).set(true)
  end

  def wait_for_ajax
    sleep 1 # TODO: actually wait for ajax and not just sleep 1
  end
end
