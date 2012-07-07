class ProfileController < ApplicationController
  before_filter :authenticate_user!
  def index
    @next_match = Calendar.next_match
    @users = User.top_scorers_of(9)
    @first_team = FirstTeam.last_of_the_round
    if found_first_team? @first_team
      @recent_winners = @first_team.squad_winners
      @formation = @first_team.formation
    end
  end
end
