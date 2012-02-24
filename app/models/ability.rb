# See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can [:index, :create, :list, :show, :reports], Formation
        can [:newly_created, :destroy], Formation, :owner_id => user.id
        can [:show, :update, :destroy], User, :id => user.id
        can :bahia_squad, Player
        can :index, Calendar
      end    
  end
end
