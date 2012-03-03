class FormationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :reports]

  respond_to :json, :html

  def index
    redirect_to :new
  end

  def new
  end
  
  def current_user_formations
    @formations = current_user.formations
  end

  def create
    formation = Formation.create_from(params[:_json], current_user)
    if formation.save
      formation.save_all_players
    end
  end
  
  def update
    @formation = Formation.find(params[:id])
    redirect_to @formation, :notice => t(:formation_updated)
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
    @players_positions = @formation.players_ordered_by_positions
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
    name = params["player_name"].capitalize if (params["player_name"])
    @player = Player.find_by_name(name)
    if @player
      @player
    else
      @player = Player.new
    end
  end

end
