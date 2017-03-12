# Основной контролер
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :user_status

  private

  # Метод для создания сессии по пользвателю.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Проверка статуса пользователя
  def user_status
    @user_status = if @current_user && @current_user.admin?
                     'admin'
                   else
                     'user'
                   end
  end

  # Проверка доступа
  def access
    redirect_to root_path, flash[:error] = 'Недостаточно прав' unless
                           @user_status == 'admin'
  end
end
