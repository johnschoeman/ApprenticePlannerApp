require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "PUT /entries/:entry_id/notes/:id", type: :request do
  context "the user owns the entry" do
    it "updates the note" do
      user = create(:user)
      entry = create(:entry, user: user)
      original_note_content = Faker::Lorem.paragraph
      note = create(:note, entry: entry, content: original_note_content)
      new_note_content = Faker::Lorem.paragraph

      put entry_note_path(entry, note, as: user),
          params: { note: { content: new_note_content } }

      entry.note.reload
      expect(entry.note.content).to eq new_note_content
    end
  end

  context "the user does not own the entry" do
    it "rejects the request to update and doesn't edit a note" do
      user = create(:user)
      other_user = create(:user)
      other_users_entry = create(:entry, user: other_user)
      original_note_content = Faker::Lorem.paragraph
      other_users_note = create(:note, entry: other_users_entry,
                                       content: original_note_content)
      new_note_content = Faker::Lorem.paragraph

      put entry_note_path(other_users_entry, other_users_note, as: user),
        params: { note: { content: new_note_content } }

      other_users_entry.note.reload
      expect(other_users_entry.note.content).to eq original_note_content
    end
  end
end
