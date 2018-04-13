require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "DELETE /entries/:id", type: :request do
  context "the user owns the entry" do
    it "deletes the entry" do
      user = create(:user)
      entry = create(:entry, user: user)

      delete entry_path(entry, as: user)

      expect(response).to redirect_to entries_path
      expect(Entry.exists?(entry.id)).to eq false
    end
  end

  context "the user does not own the entry" do
    it "doesn't delete the entry" do
      other_user = create(:user)
      other_users_entry = create(:entry, user: other_user)
      current_user = create(:user)

      delete entry_path(other_users_entry, as: current_user)

      expect(response).to redirect_to entries_path
      expect(Entry.exists?(other_users_entry.id)).to eq true
    end
  end
end
