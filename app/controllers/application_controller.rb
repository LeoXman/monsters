class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user, :user_status

  private

  # Метод для создания сессии по пользвателю.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Проверка статуса пользователя
  def user_status
    if current_user
      unless @user_status
        user = @current_user
          if @current_user.admin?
            @user_status = "admin"
          else
            @user_status = "user"
          end
      end
    end
  end

  # Проверка доступа
  def access
    unless @user_status == "admin"
      redirect_to root_path
      flash[:error] = "Недостаточно прав"
    end
  end
end
