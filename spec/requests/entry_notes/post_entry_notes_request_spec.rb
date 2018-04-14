require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "POST /entries/:id/notes", type: :request do
  context "the user owns the entry" do
    it "creates a new note" do
      user = create(:user)
      entry = create(:entry, user: user)
      note_content = Faker::Lorem.paragraph

      post entry_notes_path(entry, as: user),
        params: { note: { content: note_content } }

      expect(entry.note).to be_persisted
      expect(entry.note.content).to eq note_content
    end
  end

  context "the user does note own the entry" do
    it "rejects the request to create a new note" do
      current_user = create(:user)
      other_user = create(:user)
      other_users_entry = create(:entry, user: other_user)
      new_note_content = Faker::Lorem.paragraph

      post entry_notes_path(other_users_entry, as: current_user),
        params: { note: { content: new_note_content } }

      expect(other_users_entry.note).to be nil
    end
  end
end
