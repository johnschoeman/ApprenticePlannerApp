class Note < ApplicationRecord
  validates :content,
    length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates :entry_id, uniqueness: true

  belongs_to :entry
end
