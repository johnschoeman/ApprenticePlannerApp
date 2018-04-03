class EntryForm
  include ActiveModel::Model
  extend ActiveModel::Naming

  def initialize(date: nil, user: nil, goal_descriptions: Array.new(3) {""})
    @date = date
    @user = user
    @goal_descriptions = goal_descriptions
    @entry = Entry.new(date: date, user: user)
    @goals = @goal_descriptions.map { |description| Goal.new(description: description) }
  end

  attr_reader :entry, :goals, :date

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      add_error_messages
      false
    end
  end

  private

  def valid?
    entry_validation = entry.valid?
    goals_validations = goals.all?(&:valid?)
    entry_validation && goals_validations
  end

  def persist!
    ActiveRecord::Base.transaction do
      entry.save!
      create_goals_for_entry!
    end
  end

  def create_goals_for_entry!
    goals.each { |goal| goal.update!(entry: entry) }
  end

  def add_error_messages
    add_entry_error_messages
    add_goal_error_messages
  end

  def add_entry_error_messages
    entry.errors.full_messages.each do |message|
      errors.add(:entry, message)
    end
  end

  def add_goal_error_messages
    goals.each do |goal|
      goal.errors.full_messages.each do |message|
        errors.add(:goal, message)
      end
    end
  end
end
