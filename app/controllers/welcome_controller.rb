require 'cache'
class WelcomeController < ApplicationController

  def index
    @next_match = Calendar.next_match
    @first_team = FirstTeam.last_of_the_round
    if found_first_team? @first_team
      @recent_winners = @first_team.squad_winners
      @formation = @first_team.formation
    end
  end

  def ecbahia_news
    @ecbahia_news = Cache.fetch(key: 'ecbahia') { EcBahiaReader.new.breaking_news(5) }
    respond_to do |format|
      format.html
      format.json  { render :json => @ecbahia_news.as_json }
    end
  end

  def globoesporte_news
    @globoesporte_news = Cache.fetch(key: 'globoesporte') { GloboEsporteReader.new.breaking_news(4) }
    respond_to do |format|
      format.html
      format.json  { render :json => @globoesporte_news.as_json }
    end
  end
end
