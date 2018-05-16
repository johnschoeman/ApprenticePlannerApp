require "rails_helper"

RSpec.describe WeeklySummaryJob, type: :job do
  it "enqueues to the default queue" do
    ActiveJob::Base.queue_adapter = :test

    WeeklySummaryJob.perform_later

    expect(WeeklySummaryJob).to have_been_enqueued.on_queue("default")
  end
end
