require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "User deletes a journal entry" do
  def have_entry_item_by_date(date)
    have_css(".entry-item", text: date.to_s)
  end

  def have_success_message(message)
    have_css(".flash-success", text: message)
  end

  scenario "deletes an entry" do
    todays_date = Date.today
    tomorrows_date = todays_date.next_day
    user = create(:user)
    entry_to_delete = Entry.create(date: todays_date, user: user)
    Entry.create(date: tomorrows_date, user: user)

    visit entry_path(entry_to_delete, as: user)
    click_on "Delete Entry"

    expect(page).to have_content("Entries Index")
    expect(page).to have_success_message("Entry has been deleted")
    expect(page).to_not have_entry_item_by_date(todays_date)
    expect(page).to have_entry_item_by_date(tomorrows_date)
  end
end
