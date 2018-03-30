class Entry < ApplicationRecord
  validates :user, uniqueness: { scope: :date }
  validates :date, presence: true

  has_many :goals, dependent: :destroy
  belongs_to :user

  def self.build_entry(params)
    ActiveRecord::Base.transaction do
      entry = create({ date: params[:date], user: params[:user] })
      entry.add_goals(params[:goals])
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
