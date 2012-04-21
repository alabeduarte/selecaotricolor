class WelcomeController < ApplicationController
  
  def index
    @users = User.top_scorers_of 5
    first_team = FirstTeam.last_of_the_round
    @recent_winners = first_team.squad_winners_of_the_round(Calendar.last_match)
    @formation = first_team.formation
    @players_positions = @formation.players_ordered_by_positions
  end
  
end
