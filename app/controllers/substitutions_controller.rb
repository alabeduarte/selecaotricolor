class SubstitutionsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def new
    @first_teams = FirstTeam.all_by_match  
  end
    
  def create
    substitution = Substitution.new(params[:substitution])
    if substitution.save
      flash[:notice] = t(:replacement_registered_successfully)
      render :action => "show"
    end    
  end
  
  def show
    @substitution = Substitution.find(params[:id])    
  end

  def destroy
  end
end
