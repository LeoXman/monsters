# Голосование
class Poll < ActiveRecord::Base
  belongs_to :monster
  has_many :vote
end
