# Пользователи
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Список пользователей
  def index
    @users = User.all
  end

  # Профиль пользователя
  def show
    redirect_to root_path, flash: { error: 'Доступ запрещен' } unless
                current_user && current_user.id == @user.id
  end

  # Создание пользователей
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html do
          redirect_to @user, notice: 'Успешно зарегистрирован.'
        end
      else
        render :new
      end
    end
  end

  # Обновление пользователя
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html
        redirect_to @user,
                    notice: 'Данные обновлены.'
      else
        format.html { render :edit }
      end
    end
  end

  # Удаление пользователя
  def destroy
    @user.destroy
    respond_to do |format|
      format.html
      redirect_to users_url,
                  notice: 'Пользователь успешно удален.'
      format.json { head :no_content }
    end
  end

  # Аутентификация /auth
  def auth
    redirect_to root_path, flash: { success: 'Вход уже выполнен' } if
    current_user
  end

  def list_monsters
    user_monsters =
      Monster.where(
        own: @current_user.id
      )
    @monsters = user_monsters.page(1).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :status)
  end
end
