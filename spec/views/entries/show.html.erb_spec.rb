require "rails_helper"

RSpec.describe "entries/show.html.erb" do
  it "correctly renders an entry's goals" do
    user = build_stubbed(:user)
    entry = create(:entry, :with_goals, goals_count: 3, user: user)
    note = build_stubbed(:note, entry: entry)
    render_entry(entry, note, current_user: user)

    expect(rendered).to have_goal_list_items(count: 3)
  end

  context "the current user is the owner of the entry" do
    it "renders the edit and delete buttons" do
      user = build_stubbed(:user)
      entry = build_stubbed(:entry, user: user)
      note = build_stubbed(:note, entry: entry)
      render_entry(entry, note, current_user: user)

      expect(rendered).to have_selector(:link_or_button, "Edit Entry")
      expect(rendered).to have_selector(:link_or_button, "Delete Entry")
    end
  end

  context "the current user is not the owner of the entry" do
    it "doesn't render edit or delete buttons" do
      current_user = build_stubbed(:user)
      other_user = build_stubbed(:user)
      other_users_entry = build_stubbed(:entry, user: other_user)
      other_users_note = build_stubbed(:note, entry: other_users_entry)
      render_entry(other_users_entry, other_users_note,
                   current_user: current_user)

      expect(rendered).to_not have_selector(:link_or_button, "Edit Entry")
      expect(rendered).to_not have_selector(:link_or_button, "Delete Entry")
    end
  end

  def render_entry(entry, note, current_user: nil)
    assign(:entry, entry)
    assign(:current_user, current_user)
    assign(:note, note)
    assign(:goals, entry.goals)

    render
  end

  def have_goal_list_items(count: 1)
    have_selector("li.goal-summary", count: count)
  end
end
