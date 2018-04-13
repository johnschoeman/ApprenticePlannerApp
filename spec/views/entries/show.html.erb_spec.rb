require 'rails_helper'

RSpec.describe "entries/show.html.erb" do
  context "the current user is the owner of the entry" do
    it "renders the edit and delete buttons" do
      user = build_stubbed(:user)
      entry = build_stubbed(:entry, user: user)
      render_entry(entry, current_user: user)

      expect(rendered).to have_selector(:link_or_button, "Edit Entry")
      expect(rendered).to have_selector(:link_or_button, "Delete Entry")
    end
  end

  context "the current user is not the owner of the entry" do
    it "doesn't render edit or delete buttons" do
      current_user = build_stubbed(:user)
      other_user = build_stubbed(:user)
      other_users_entry = build_stubbed(:entry, user: other_user)
      render_entry(other_users_entry, current_user: current_user)

      expect(rendered).to_not have_selector(:link_or_button, "Edit Entry")
      expect(rendered).to_not have_selector(:link_or_button, "Delete Entry")
    end
  end

  def render_entry(entry, current_user: nil)
    assign(:entry, entry)
    assign(:current_user, current_user)

    render
  end
end
