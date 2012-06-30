class NewslettersController < ApplicationController
  authorize_resource :class => false
  before_filter :authenticate_user!
  
  respond_to :json, :html
  
  def index
    @emails = Newsletter.all(User.all_by_score)
    first_team = FirstTeam.last_of_the_round
    if first_team
      @match = first_team.match
      @predicted_score = first_team.predicted_score
      @winners_of_round = Newsletter.all(first_team.squad_winners)
    end
  end
end
