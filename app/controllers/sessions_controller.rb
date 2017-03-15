# Users sessions
class SessionsController < ApplicationController
  # Новая сессия пользователя
  def create
    user = User.sing_in_user(params)
    if user
      session[:user_id] = user.id
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
