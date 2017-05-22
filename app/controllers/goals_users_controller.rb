class GoalsUsersController < ApplicationController

  def create
    goal = GoalsUser.create(user_id: current_user.id, goal_id: params[:goal_id])
    redirect_to "/users/#{params[:user_id]}"
  end

  def update
    goal_user = GoalsUser.find_by(user: current_user, goal_id: params[:id])
    goal_user.update_attributes({completed: params[:completed], review: params[:review]})
    redirect_to "/users/#{current_user.id}"
  end

  def return_basket
    goal_user = GoalsUser.find_by(user: current_user, goal_id: params[:id])
    goal_user.update_attributes({completed: false})
    redirect_to "/users/#{current_user.id}"
  end

  def destroy
    goal_user = GoalsUser.find_by(user: current_user, goal_id: params[:id])
    goal_user.destroy
    redirect_to "/users/#{params[:user_id]}"
  end

end
