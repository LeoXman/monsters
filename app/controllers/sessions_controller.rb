# Users sessions
class SessionsController < ApplicationController
  # Создание новой сессии
  def create
    user              = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Signed in!'
  end

  # Новая сессия(локальная авторизация)
  def create_via_password
    user                = User.sing_in_user(params)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back, flash: { error: 'Пользователь не найден.' }
    end
  end

  # Удаление сессии
  def sign_out
    session[:user_id] = nil
    redirect_to root_url
  end

  # Провал сессии
  def failure
    render text: 'Ошибка авторизации'
  end
end
