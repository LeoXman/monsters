module ApplicationHelper
  def check_favorite(id)
    @user = User.find(@current_user.id)
    favoritelist = @user.favorites.where(monster_id: id)
    unless favoritelist.blank?
      return true
    end
  end
  def check_like(monster)
    user = @current_user.id
    user = user.to_s
    @monster = Monster.find(monster)
    stamps = @monster.vote_stamps.to_s
    if stamps.include? user
      return true
    end
  end
end
