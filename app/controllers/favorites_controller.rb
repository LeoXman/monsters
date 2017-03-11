class FavoritesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    user_monsters = @user.favorites.all
  end

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
