class FirstTeamsController < ApplicationController
  
  def new
    @matches = Calendar.with_tactics
  end
  
  def create
    FirstTeam.create_from(data: params[:_json], owner: current_user)   
  end
  
  def show
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
