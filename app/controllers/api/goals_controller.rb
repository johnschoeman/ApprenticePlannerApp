module Api
  class GoalsController < ApplicationController
    before_action :require_entry_to_belong_to_user

    def update
      goal.toggle(:completed)
      goal.save
    end

    private

    def goal
      @_goal ||= Goal.find(params[:id])
    end

    def entry
      @_entry_for_goal ||= goal.entry
    end

    def require_entry_to_belong_to_user
      unless entry.user == current_user
        head(403)
      end
    end
  end
end
