class Entry < ApplicationRecord
  validates :date,
    uniqueness: { scope: :user_id, message: "already has an entry" }
   validates :date, presence: true

  has_many :goals, -> { order(id: :asc) }, dependent: :destroy
  belongs_to :user

  def self.build_goal(description: nil, entry: nil)
    Goal.new(description: description, entry: entry)
  end

  def goal_descriptions
    goals.map { |goal| goal.description }
  end
end
