# Сообщения между пользователями
class Message < ActiveRecord::Base
  belongs_to :user
end
