class Entry < ApplicationRecord
  validates :date,
    uniqueness: { scope: :user_id, message: "already has an entry" }
   validates :date, presence: true

  has_many :goals, dependent: :destroy
  belongs_to :user
end
