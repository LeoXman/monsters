# Избранные монстры
class FavoritesController < ApplicationController
  # Все избранные монстры пользователя
  def index
    @user = User.find(params[:user_id])
  end

  # Добавление монстра в избранное
  def create
    @user = User.find(params[:user_id])
    favorite = @user.favorites.new(favorite_params)
    favorite.monster_id = monster.id
    favorite.save

    redirect_to user_path(@user)
  end

  private

  def message_params
    params.require(:message).permit(:title, :text)
  end
end
