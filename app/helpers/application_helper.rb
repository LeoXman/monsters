# Основные хелперы
module ApplicationHelper
  def check_favorite(id)
    @user = User.find(@current_user.id)
    favoritelist = @user.favorites.where(monster_id: id)
    return true unless favoritelist.blank?
  end

  def check_like(monster)
    user = @current_user.id
    user = user.to_s
    @monster = Monster.find(monster)
    stamps = @monster.vote_stamps.to_s
    return true if stamps.include? user
  end
end
