class FormationsController < ApplicationController

  respond_to :json, :html

  def index
    @next_match = next_match
  end

  def send_formation
    formation = Formation.create_from params[:_json]
    formation.team = current_team
    formation.match = next_match
    if formation.save
      formation.players_positions.each do |player_position_formation|
        player_position_formation.save
      end
    end
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
  
private
  def current_team
    Team.first(name: 'Bahia')
  end
  
  def next_match
    Calendar.first(:day => {:$gte => Time.now})
  end

end
