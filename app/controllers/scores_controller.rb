class ScoresController < ApplicationController
  respond_to :json, :html

  def index
    @users = User.all_by_score
    @users
  end
  
  def rules    
  end
  
end
