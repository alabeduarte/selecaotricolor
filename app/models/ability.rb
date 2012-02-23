# See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.role? :admin
        can :manage, :all
      else
        can [:create, :read], Formation
        can [:update, :destroy], Formation, :owner_id => user.id
        can [:read, :update, :destroy], User, :id => user.id
        can :read, [Player, PlayerFormationPosition, PositionMapper, Team, Calendar]
      end    
  end
end
