require "rails_helper"

RSpec.describe "GET /entry/:id", type: :request do
  it "doesn't return blank goals" do
    goals_count = 2
    entry = create(:entry_with_goals, goals_count: goals_count)
    create(:goal, :blank, entry: entry)

    get entry_path(entry)

    expect(count_of_goals_in_response).to eq goals_count
  end

  def count_of_goals_in_response
    response.body.scan("goal-summary").size
  end
end
