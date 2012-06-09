class SubstitutionsController < ApplicationController
  
  def new
    @first_teams = FirstTeam.all  
  end
  
  def create
    @first_team = FirstTeam.find(params[:id])
    if @first_team.update_attributes(params[:first_team])
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
