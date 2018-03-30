class Goal < ApplicationRecord
  validates_length_of :description, maximum: 255
  belongs_to :entry
end
