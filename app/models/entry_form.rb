class EntryForm
  include ActiveModel::Model

  attr_accessor :date, :user, :goal_descriptions

  delegate :id, :persisted?, to: :entry

  validate :validate_children

  def self.model_name
    Entry.model_name
  end

  def self.find_by_entry_id(entry_id)
    entry = Entry.includes(:goals).find(entry_id)
    entry_form = new
    entry_form.entry = entry
    entry_form.date = entry.date
    entry_form.goals = entry.goals
    entry_form
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        entry.save!
        goals.each do |goal|
          goal.save!
        end
      end
    end
  end

  def update_attributes(params)
    set_attributes(params)
    save
  end

  def entry
    @entry ||= Entry.new(date: date, user: user)
  end

  def goals
    if @goals
      @goals
    else
      if goal_descriptions
        goal_descriptions.map { |desc| Entry.build_goal(description: desc, entry: entry) }
      else
        Array.new(3) { Goal.new }
      end
    end
  end

  def entry=(entry)
    @entry = entry
  end

  def goals=(goals)
    @goals = goals
  end

  private

  def set_attributes(date: nil, user: nil, goal_descriptions: [])
    entry.date = date
    entry.user = user
    goals.zip(goal_descriptions).each do |(goal, description)|
      goal.description = description
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
