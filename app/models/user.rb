# Пользователи
class User < ActiveRecord::Base
  as_enum :status, admin: 1, user: 0
  has_many :favorites
  has_many :messages
  has_many :comments
  has_many :monsters
  has_many :vote
  # validates
  validates :username, presence: true
  validates :email, uniqueness: true

  # Скоупы
  scope :set_user,
        ->(params) {
          find_by(username: params[:sessions][:username],
                  password: params[:sessions][:password])
        }
end
