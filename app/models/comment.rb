# Комментарии пользователей
class Comment < ActiveRecord::Base
  belongs_to :monster
  # validates
  validates :text, length: { minimum: 50 }
end
