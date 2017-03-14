# Users sessions
class SessionsController < ApplicationController
  before_action :set_user, only: [:create]
  # Новая сессия
  def create
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to :back, flash: { error: 'Пользователь не найден.' }
    end
  end

  # Удаление сессии
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

private

# Лоин и пароль пользователя
def set_user
  @user = User.find_by(
    username: params[:sessions][:username],
    password: params[:sessions][:password]
  )
end
