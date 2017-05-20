class GoalsController < ApplicationController

  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def create
  end

end
