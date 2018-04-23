require "rails_helper"

RSpec.feature "User navigates to the entry index" do
  scenario "clicks on the Tidbit of the Day", :include_stack_overflow_helpers do
    stub_api_request
    visit entries_path

    expect(page).to have_tidbit
  end

  def have_tidbit
    have_css(".tidbit-link")
  end
end
