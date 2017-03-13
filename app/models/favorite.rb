# Избранные монстры пользователей
class Favorite < ActiveRecord::Base
  belongs_to :user
end
