class ScoresController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  respond_to :json, :html

  def index
    @users = User.all_by_score
    @users
  end
  
end
