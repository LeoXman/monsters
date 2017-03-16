# Users sessions
class SessionsController < ApplicationController
  # Новая сессия(локальная авторизация)
  def createlocal
    user = User.sing_in_user(params)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back, flash: { error: 'Пользователь не найден.' }
    end
  end

  # Создание новой сессии
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Signed in!'
  end

  # Удаление сессии
  def signout
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  # Удаление локальной сессии (временно)
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  # Провал сессии
  def failure
    render text: 'FAILURE :-('
  end
end
