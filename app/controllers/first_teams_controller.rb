class FirstTeamsController < ApplicationController
  
  def new
    @matches = Calendar.with_tactics
  end
  
  def create
    @first_team = FirstTeam.create_from(
                                        data: params[:_json],
                                        owner: current_user)   
    if @first_team
      @first_team.apply_score_to_all_users
      @first_team.apply_score_to_predict_users
      flash[:notice] = t(:formation_sent)
      redirect_to first_team_path(@first_team)
    else
      render :new
    end
  end
  
  def show
    @first_team = FirstTeam.find(params[:id])
    @formation = @first_team.formation
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
  
  def index
    @first_teams = FirstTeam.all    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @first_teams }
      format.json  { render :json => @first_teams }
    end
  end
  
end
