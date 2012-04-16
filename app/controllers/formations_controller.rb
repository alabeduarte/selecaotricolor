class FormationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :reports]
  caches_action :index, :current_user_formations, :list, :show
  
  respond_to :json, :html

  def index
    redirect_to :new
  end

  def new
    if Formation.already_created?(current_user, Calendar.next_match)
      redirect_to :current_user_formations, :notice => t(:formation_once_per_match)
    end
  end
  
  def current_user_formations
    @formations = current_user.formations
  end

  def create
    @formation = Formation.new_by(data: params[:_json], owner: current_user)
    @formation.save
    expire_cache(@formation)
  end
  
  def update
    @formation = Formation.find(params[:id])
    expire_cache(@formation)
    redirect_to @formation, :notice => t(:formation_updated)
  end
  
  def newly_created
    formation = Formation.newly_created(current_user)
    redirect_to formation, :notice => t(:formation_sent)
  end

  def list
    @formations = Formation.all
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @formations }
      format.json  { render :json => @formations }
    end
  end
  
  def show
    @formation = Formation.find(params[:id])
    @players_positions = @formation.players_ordered_by_positions
    respond_to do |format|
      format.html
      format.json  { 
        render :json => @formation.as_json(:include => {
          :players_positions => {:include => :player}
        }) 
      }
    end
  end
  
  def edit
  end
  
  def destroy
    @formation = Formation.find(params[:id])
    expire_cache(@formation)
    @formation.destroy    
    flash[:notice] = t(:formation_destroyed)
    redirect_to(formations_path)
  end
  
  def reports
    name = params["player_name"].capitalize if (params["player_name"])
    @player = Player.find_by_name(name)
    if @player
      @player
    else
      @player = Player.new
    end
  end
  
private
  def expire_cache(formation=nil)
    expire_action :action => :index
    expire_action :action => :current_user_formations
    expire_action :action => :list
    expire_action :action => :show, :id => formation
    expire_action(:controller => :calendars, :action => :index)
    expire_action(:controller => :calendars, :action => :formations_matches, :id => formation.match)
  end

end
