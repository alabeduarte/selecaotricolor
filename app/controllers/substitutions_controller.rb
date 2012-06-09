class SubstitutionsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def new
    @first_teams = FirstTeam.all_by_match  
  end
  
  def create
    first_team = FirstTeam.find(params[:first_team_id])
    first_team << Substitution.new(off: params[:off_id], on: params[:on_id])
    if first_team.save
      flash[:notice] = t(:replacement_registered_successfully)
    end
    render :action => "show"
  end
  
  def show
    @substitution = Substitution.find(params[:id])    
  end

  def destroy
  end
end
