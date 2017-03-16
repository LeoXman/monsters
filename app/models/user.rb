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
  scope :sing_in_user,
        ->(params) {
          find_by(username: params[:sessions][:username],
                  password: params[:sessions][:password])
        }
  # Получение пользователя из соц.сетей
  def self.from_omniauth(auth)
    where(provider: auth.provider,
          uid: auth.uid).first || create_from_omniauth(auth)
  end

  # Создание пользователя в базе
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.username = auth['info']['nickname'] ? auth['info']['nickname'] : auth['info']['name']
    end
  end
end
