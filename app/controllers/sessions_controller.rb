class SessionsController < ApplicationController
  def create
    user =
      User.find_by(
        username: params[:sessions][:username], password: params[:sessions][:password]
      )
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back, flash: { error: 'User not found' }
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to root_path, flash: { success: 'Logged out' }
    else
      raise session[:user_id].inspect
    end
  end
end
