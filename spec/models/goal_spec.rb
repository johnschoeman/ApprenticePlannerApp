require "rails_helper"

RSpec.describe Goal, type: :model do
  it { should belong_to(:entry) }
  it { should validate_presence_of(:description).with_message("can't be nil") }
  it { should allow_value("").for(:description) }
  it { should validate_length_of(:description).is_at_most(255) }

  describe ".with_descriptions" do
    it "includes goals with descriptions" do
      goal = create(:goal)

      expect(Goal.with_descriptions).to include goal
    end

    it "excludes goals without descriptions" do
      blank_goal = create(:goal, :blank)

      expect(Goal.with_descriptions).to_not include blank_goal
    end
  end
end
