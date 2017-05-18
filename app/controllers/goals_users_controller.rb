class GoalsUsersController < ApplicationController

  def create
    GoalsUser.create(user_id: current_user.id, goal_id: params[:goal_id])
    redirect_to "/"
  end

end
