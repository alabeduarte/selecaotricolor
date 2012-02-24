class FormationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:index, :show, :reports]

  respond_to :json, :html

  def index
  end

  def create
    formation = Formation.create_from(params[:_json], current_user)
    if formation.save
      formation.save_all_players
    end
  end
  
  def newly_created
    formation = Formation.newly_created(current_user)
    redirect_to formation, :notice => t(:formation_sent)
  end

  def list
    @formations = Formation.all
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @formations }
      format.json  { render :json => @formations }
    end
  end
  
  def show
    @formation = Formation.find(params[:id])

    respond_to do |format|
      format.html
      format.json  { 
        render :json => @formation.as_json(:include => {
          :players_positions => {:include => :player}
        }) 
      }
    end
  end
  
  def edit
  end
  
  def destroy
    @formation = Formation.find(params[:id])    
    @formation.destroy

    respond_to do |format|
      format.html { redirect_to(formations_url) }
      format.xml  { head :ok }
    end
  end
  
  def reports
    @player = Player.find_by_name(params["player_name"])
    if @player
      @player
    else
      @player = Player.new
    end
  end

end
