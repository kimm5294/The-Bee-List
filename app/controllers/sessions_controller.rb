class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "You have successfully logged in!"
    else
      @errors = ["Invalid email and/or password"]
      render 'new'
    end
  end

  def destroy
    session[:user_id] = @current_user = nil
    redirect_to root_url
  end
end
