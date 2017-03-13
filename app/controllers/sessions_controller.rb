# Users sessions
class SessionsController < ApplicationController
  # Новая сессия
  def create
    user =
      User.find_by(
        username: params[:sessions][:username],
        password: params[:sessions][:password]
      )
    if user
      session[:user_id] = user.id redirect_to root_path
    else
      redirect_to :back, flash: { error: 'Пользователь не найден.' }
    end
  end

  # Удаление сессии
  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: 'Вы успешно вышли из аккаунта.' }
  end
end
