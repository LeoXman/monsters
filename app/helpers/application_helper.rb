# Основные хелперы
module ApplicationHelper
  def check_favorite(id)
    @user = User.find(@current_user.id)
    favoritelist = @user.favorites.where(monster_id: id)
    favoritelist.blank?
  end
end
