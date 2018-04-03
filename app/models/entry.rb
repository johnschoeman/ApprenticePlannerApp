class Entry < ApplicationRecord
  validates :date,
    uniqueness: { scope: :user, message: ": Already an entry for this date" }
   validates :date, presence: true

  has_many :goals, dependent: :destroy
  belongs_to :user

  def self.create_entry(params)
    ActiveRecord::Base.transaction do
      entry = new({ date: params[:date], user: params[:user] })
      if entry.save
        entry.add_goals(params[:goals])
      end
      entry
    end
  end

  def add_goals(descriptions_array)
    descriptions_array.each do |description|
      add_goal(description)
    end
  end

  def add_goal(description)
    Goal.create(description: description, entry: self)
  end
end
