class WeeklySummaryJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger "sending weekly summaries"
    User.find_each do |user|
      UserMailer.with(user: user).weekly_summary.deliver_now
    end
  end
end
