class HomepageController < ApplicationController
  def index
    if logged_in?
      redirect_to "/users/#{current_user.id}"
    end
  end

end
