class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def authenticate_user
    if !current_user
      redirect_to signin_path, notice: "You must be signed in to do that!"
    end
  end

  helper_method :current_user, :authenticate_user
end
