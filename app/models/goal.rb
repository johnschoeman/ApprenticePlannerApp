class Goal < ApplicationRecord
  validates_length_of :description, maximum: 255
  validates :completed, inclusion: { in: [true, false] }

  belongs_to :entry
end
