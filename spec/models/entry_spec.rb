require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "Validations" do
    subject { create(:entry) }
    it { should validate_uniqueness_of(:user).scoped_to(:date) }
    it { should validate_presence_of(:user).with_message("must exist") }
    it { should validate_presence_of(:date) }
    it { should have_many(:goals) }
  end

  describe "#add_goals" do
    it "adds goals to an entry" do
      entry = build(:entry)
      goals = Array.new(3) { Faker::Lorem.sentence }

      entry.add_goals(goals)

      expect(entry.goals.pluck(:description).sort).to eq goals.sort
    end
  end

  describe "#add_goal" do
    it "adds a goal to an entry" do
      entry = build(:entry)
      goal_description = Faker::Lorem.sentence

      entry.add_goal(goal_description)

      expect(entry.goals.pluck(:description)).to include goal_description
    end
  end
end
