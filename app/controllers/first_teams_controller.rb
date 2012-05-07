class FirstTeamsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:last_squad_of_the_round]
  
  respond_to :json, :html
  
  def new
    @matches = Calendar.with_tactics
  end
  
  def last_squad_of_the_round
    respond_to do |format|
      format.html
      format.json  { 
        render :json => FirstTeam.last_of_the_round.formation.as_json(:include => {
          :players_positions => {:include => :player}
        }) 
      }
    end
  end
  
  def create
    selected_match = Calendar.find(params[:match_id])
    formation = Formation.new_by(
                                  match: selected_match,
                                  data: params[:_json],
                                  owner: current_user)    
    @first_team = FirstTeam.new(formation: formation)   
    if @first_team.save
      @first_team.apply_score(Scorer.new(match: selected_match))
      flash[:notice] = t(:formation_sent)
      redirect_to first_team_path(@first_team)
    else
      render :new
    end
  end
  
  def show
    @first_team = FirstTeam.find(params[:id])
    @formation = @first_team.formation
    respond_to do |format|
      format.html
      format.json  { 
        render :json => @formation.as_json(:include => {
          :players_positions => {:include => :player}
        }) 
      }
    end
  end
  
  def index
    @first_teams = FirstTeam.all    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @first_teams }
      format.json  { render :json => @first_teams }
    end
  end
  
  def destroy
    @first_team = FirstTeam.find(params[:id])    
    @first_team.destroy

    respond_to do |format|
      format.html { redirect_to(first_teams_url) }
      format.xml  { head :ok }
    end
  end
  
end
