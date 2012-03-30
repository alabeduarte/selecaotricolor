class ScoresController < ApplicationController
  def index
    @users = User.all_by_score
    respond_to do |format|
      format.html
      format.xml  { render :xml => @users }
      format.json  { render :json => @users }
    end
  end
end
