# Пользователи
class User < ActiveRecord::Base
  as_enum :status, admin: 1, user: 0
  has_many :favorites
  has_many :messages
  has_many :comments
  has_many :monsters
  # validates
  validates :username, presence: true
  validates :email, uniqueness: true
end
