class WelcomeController < ApplicationController
  
  def index
    @next_match = Calendar.next_match
    @first_team = FirstTeam.last_of_the_round
    if found_first_team? @first_team
      @recent_winners = @first_team.squad_winners
      @formation = @first_team.formation
    end
    @news = EcBahiaReader.new.breaking_news(5)
  end
end
