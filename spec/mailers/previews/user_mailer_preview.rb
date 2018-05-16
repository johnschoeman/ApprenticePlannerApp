# Preview all emails at http://localhost:3000/rails/mailers/summary_mailer
class UserMailerPreview < ActionMailer::Preview
  def weekly_summary_preview
    user = FactoryBot.create(:user)
    entry = FactoryBot.create(:entry, date: 1.day.ago, user: user)
    FactoryBot.create(:note, entry: entry, content: Faker::Lorem.sentence)

    UserMailer.with(user: user).weekly_summary
  end
end
