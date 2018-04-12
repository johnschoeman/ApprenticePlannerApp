class EntryForm
  include ActiveModel::Model

  attr_reader :entry, :goals

  delegate :id, :persisted?, :date, to: :entry

  validate :validate_children

  def initialize(entry: nil)
    @entry = entry || Entry.new(date: Date.today)
    if entry && !entry.goals.empty?
      @goals = entry.goals
    else
      @goals = Array.new(3) { Goal.new }
    end
  end

  def self.model_name
    Entry.model_name
  end

  def update_attributes(params)
    set_attributes(params)
    save
  end

  private

  def set_attributes(date: nil, user: nil, goal_descriptions: [])
    entry.date = date
    entry.user = user
    goals.zip(goal_descriptions).each do |(goal, description)|
      goal.entry = entry
      goal.description = description
    end
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        entry.save!
        goals.each(&:save!)
      end
    end
  end

  def validate_children
    if entry.invalid?
      promote_errors(entry.errors)
    end

    goals.each do |goal|
      if goal.invalid?
        promote_errors(goal.errors)
      end
    end
  end

  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
end
