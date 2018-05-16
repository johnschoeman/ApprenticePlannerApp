task send_weekly_summary: :environment do
  FRIDAY = 5
  if Date.today.wday == FRIDAY
    WeeklySummaryJob.perform_now
  end
end
