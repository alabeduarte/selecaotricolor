class FormationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :reports]

  respond_to :json, :html

  def index
    redirect_to :new
  end

  def new
    next_match = Calendar.next_match
    if (next_match)
      if Formation.already_created?(current_user, next_match)
        flash[:notice] = t(:formation_once_per_match) 
        redirect_to :current_user_formations
      end
      if Formation.time_is_over?(next_match)
        flash[:notice] = t(:formation_time_is_over)
        redirect_to :controller => :calendars, :action => :formations_matches, :id => next_match 
      end
    else
      redirect_to '/'
    end
  end
  
  def current_user_formations
    @formations = current_user.formations
  end

  def create
    @formation = Formation.new_by(data: params[:_json], owner: current_user)
    @formation.save
    expire_cache(@formation.match)
  end
  
  def update
    @formation = Formation.find(params[:id])
    redirect_to @formation, :notice => t(:formation_updated)
  end
  
  def newly_created
    formation = Formation.newly_created(current_user).first
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
    expire_cache(@formation.match)
    @formation.destroy

    respond_to do |format|
      format.html { redirect_to(formations_url) }
      format.xml  { head :ok }
    end
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

end
