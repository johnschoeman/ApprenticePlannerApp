require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "#weekly_summary" do
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    include Rails.application.routes.url_helpers

    it "should have the correct to address" do
      user = build(:user)
      email = UserMailer.with(user: user).weekly_summary

      expect(email).to deliver_to(user.email)
    end

    it "should have the correct subject" do
      user = build(:user)
      email = UserMailer.with(user: user).weekly_summary

      expect(email).to have_subject(/Weekly Summary/)
    end

    it "should contain the users notes from last week" do
      user = create(:user)
      date = 1.day.ago
      entry = create(:entry, :with_note, user: user, date: date)
      email = UserMailer.with(user: user).weekly_summary

      expect(email).to have_body_text(date.strftime("%Y-%m-%d"))
      expect(email).to have_body_text(entry.note.content)
    end
  end
end
