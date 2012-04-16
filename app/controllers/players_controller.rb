class PlayersController < ApplicationController
  load_and_authorize_resource  
  before_filter :authenticate_user!
  caches_action :index, :layout => :false
  caches_action :show, :edit, :new
  
  def bahia_squad
    @players = Player.players_of Team.bahia
    respond_to do |format|
      format.json  { render :json => @players.to_json(:include => [:position_mapper]) }
    end
  end
  
  def index
    @players = Player.sort(:enabled, :position_mapper_id.desc, :name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
      format.json  { render :json => @players }
    end
  end

  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create    
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        expire_cache(@player)
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        expire_cache(@player)
        format.html { redirect_to({:action => :index}, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    expire_cache(@player)
    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end
  
private
  def expire_cache(player=nil)
    expire_action :action => :index
    expire_action :action => :new
    expire_action :action => :show, :id => player
    expire_action :action => :edit, :id => player
  end

end
