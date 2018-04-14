require "rails_helper"

RSpec.describe Note, type: :model do
  let(:entry) { create(:entry) }
  subject { Note.create(entry: entry, content: "Here is the content") }

  it { should belong_to(:entry) }
  it { should allow_value("").for(:content) }
  it { should_not allow_value(nil).for(:content) }
  it { should validate_uniqueness_of(:entry_id) }
end
