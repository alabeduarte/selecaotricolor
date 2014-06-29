require 'news'
require 'cache'
class WelcomeController < ApplicationController

  def index
  end

  def ecbahia_news
    @ecbahia_news = Cache.fetch(key: 'ecbahia') { EcBahiaReader.new.breaking_news(4) }
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
