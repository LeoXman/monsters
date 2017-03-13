# Права пользователей
class Ability
  include CanCan::Ability
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, Monster
    else
      can :read, Monster
      can :dislike, Monster do |monster|

      end
    end
  end
end
