class Goal < ApplicationRecord
  validates :description, length:
    { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates_length_of :description, maximum: 255
  validates :completed, inclusion: { in: [true, false] }

  belongs_to :entry

  def self.with_descriptions
    where.not(description: "")
  end
end
