class ConnectionsController < ApplicationController
  def create
    @user = User.find_by(id: params[:connection][:friendee_id])
    connection = Connection.new(friender_id: session[:user_id], friendee_id: @user.id)
    if connection.save
      render 'users/show'
    else
      render 'users/show'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    connection = Connection.find_by(id: params[:id])
    connection.destroy
    render 'users/show'
  end

end
