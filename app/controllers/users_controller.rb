class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @categories = Category.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render "users/show"
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def friends
    @user = User.find_by(id: params[:user_id])
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
end
