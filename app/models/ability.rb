# See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can [:new, :create, :list, :show, :reports], Formation
        can [:newly_created, :current_user_formations, :destroy], Formation, :owner_id => user.id
        can [:show, :update, :destroy], User, :id => user.id
        can :bahia_squad, Player
        can :index, Scorer
        can [:index, :formations_matches], Calendar
        can :last_squad_of_the_round, FirstTeam
      end    
  end
end
