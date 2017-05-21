class GoalsController < ApplicationController
  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def create
    goal = Goal.create(task: params[:task], api_id: params[:api_id], category_id: params[:category_id].to_i, data: params[:data], image_url: params[:image_url])
    GoalsUser.create(user_id: current_user.id, goal_id: goal.id)
    redirect_to "/users/#{current_user.id}"
  end
end
