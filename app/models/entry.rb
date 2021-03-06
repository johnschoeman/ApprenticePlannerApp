class Entry < ApplicationRecord
  validates :date,
    uniqueness: { scope: :user_id, message: "already has an entry" }
  validates :date, presence: true

  has_many :goals, -> { order(id: :asc) }, dependent: :destroy
  has_one :note, dependent: :destroy
  belongs_to :user

  def goal_descriptions
    goals.map(&:description)
  end
end
