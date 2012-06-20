class RatingController < ApplicationController
  def show
     position = PlayerFormationPosition.find(params[:id])
     @match = position.formation.match
     @player = position.player
  end

  def like
    position = PlayerFormationPosition.find(params[:id])
    @match = position.formation.match
    @player = position.player
    if @player.increase_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def unlike
    position = PlayerFormationPosition.find(params[:id])
    @match = position.formation.match
    @player = position.player
    if @player.decrease_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def show_sub
    substitution = Substitution.find(params[:id])
    @match = substitution.first_team.formation.match
    @player = substitution.on
    render "show"
  end

  def like_sub
    substitution = Substitution.find(params[:id])
    @match = substitution.first_team.formation.match
    @player = substitution.on
    if @player.increase_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def unlike_sub
    substitution = Substitution.find(params[:id])
    @match = substitution.first_team.formation.match
    @player = substitution.on
    if @player.decrease_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
end
