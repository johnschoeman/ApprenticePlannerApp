require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "PATCH /api/goals/:id", type: :request do
  context "the user owns the goal's entry" do
    it "toggles the goals completed status" do
      user = create(:user)
      entry = create(:entry, user: user)
      goal = create(:goal, entry: entry, completed: false)

      patch api_goal_path(goal, as: user)

      goal.reload
      expect(goal.completed).to be true
    end
  end

  context "the user does not own the goal's entry" do
    it "rejects the request to toggle the goal" do
      current_user = create(:user)
      other_user = create(:user)
      other_users_entry = create(:entry, user: other_user)
      other_users_goal =
        create(:goal, entry: other_users_entry, completed: false)

      patch api_goal_path(other_users_goal, as: current_user)

      other_users_goal.reload
      expect(other_users_goal.completed).to be false
    end
  end
end
