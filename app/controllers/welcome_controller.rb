class WelcomeController < ApplicationController
  
  def index
    @users = User.top_scorers_of 5
    first_team = FirstTeam.last_of_the_round
    if found? first_team
      @recent_winners = first_team.squad_winners_of_the_round
      @formation = first_team.formation
      @players_positions = @formation.players_ordered_by_positions
    end
  end

private
  def found?(first_team)
    first_team && first_team.formation && first_team.formation.players_ordered_by_positions && first_team.formation.match
  end
end
