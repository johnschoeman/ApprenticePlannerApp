require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "Entry Notes" do
  scenario "user alters existing notes" do
    user = create(:user)
    original_note_content = Faker::Lorem.paragraph
    entry = create(:entry,
                   :with_note,
                   user: user,
                   note_content: original_note_content)
    new_note_content = Faker::Lorem.paragraph

    visit entry_path(entry, as: user)
    expect(page).to have_content(original_note_content)

    fill_in "note_content", with: new_note_content
    click_on "Save Notes"

    expect(page).to have_content("Note Saved")
    expect(page).to have_content(new_note_content)
  end

  scenario "user writes new notes on todays entry",
    :include_stack_overflow_helpers do
    stub_api_request
    todays_date = Date.today
    user = create(:user)
    entry = create(:entry, :with_note, date: todays_date, user: user)
    notes_text = Faker::Lorem.paragraph

    visit entry_path(entry, as: user)
    fill_in "note_content", with: notes_text
    click_on "Save Notes"

    expect(page).to have_content(notes_text)

    user_leaves_and_revisits_entry_page(entry)
    expect(page).to have_content(notes_text)
  end

  def user_leaves_and_revisits_entry_page(entry)
    visit entries_path
    visit entry_path(entry)
  end
end
