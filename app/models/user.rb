class User < ApplicationRecord
  include Clearance::User

  has_many :entries

  def last_weeks_entries
    @last_weeks_entries ||= entries.
      where("date > ?", 1.week.ago).
      includes(:goals).
      includes(:note)
  end
end
