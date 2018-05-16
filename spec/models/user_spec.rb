require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:entries) }

  describe "#last_weeks_entries" do
    it "should return all the entrie for the last 7 days" do
      user = create(:user)
      entry1 = create(:entry, date: 1.day.ago, user: user)
      entry2 = create(:entry, date: 2.days.ago, user: user)
      not_users_entry = create(:entry, date: 3.days.ago)
      too_old_entry = create(:entry, date: 8.days.ago)

      last_weeks_entries = user.last_weeks_entries

      expect(last_weeks_entries).to include(entry1)
      expect(last_weeks_entries).to include(entry2)
      expect(last_weeks_entries).not_to include(not_users_entry)
      expect(last_weeks_entries).not_to include(too_old_entry)
    end
  end
end
