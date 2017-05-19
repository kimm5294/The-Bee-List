class ConnectionsController < ApplicationController
  def create
    @user = User.find_by(id: params[:connection][:friendee_id])
    connection = Connection.new(friender_id: session[:user_id], friendee_id: @user.id)
    if connection.save
      redirect_to "/users/#{@user.id}"
    else
      render 'users/show'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    connection = Connection.find_by(id: params[:id])

    if connection
      connection.destroy
      render 'users/show'
    else
      redirect_to "/users/#{@user.id}"
    end
  end

end
