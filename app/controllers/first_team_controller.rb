class FirstTeamController < ApplicationController
  
  def new
    @matches = Calendar.with_tactics
  end
  
  def create    
  end
  
  def newly_created
  end
  
end
