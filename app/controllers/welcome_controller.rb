class WelcomeController < ApplicationController
  
  def index
    @next_match = Calendar.next_match
    @first_team = FirstTeam.last_of_the_round
    if found? @first_team
      @recent_winners = @first_team.squad_winners
      @formation = @first_team.formation
    end
  end

private
  def found?(first_team)
    first_team && first_team.formation && first_team.formation.players_ordered_by_positions && first_team.formation.match
  end
end
