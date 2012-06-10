class RatingController < ApplicationController
  def show
    @position = PlayerFormationPosition.find(params[:id])
  end

  def like
    @position = PlayerFormationPosition.find(params[:id])
    player = @position.player
    if player.increase_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def unlike
    @position = PlayerFormationPosition.find(params[:id])
    player = @position.player
    if player.decrease_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def show_sub
    @substitution = Substitution.find(params[:id])
  end

  def like_sub
    @substitution = Substitution.find(params[:id])
    player = @substitution.on
    if player.increase_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
  
  def unlike_sub
    @substitution = Substitution.find(params[:id])
    player = @substitution.on
    if player.decrease_rating
      respond_to do |format|
        render :json => { :success => true }
      end
    end
  end
end
