class FormationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:show, :reports]
  before_filter :check_exist_next_match, :time_limit_check, :formation_has_created_check, :only => :new

  respond_to :json, :html

  def index
    redirect_to :new
  end

  def new
  end
  
  def current_user_formations
    @formations = current_user.formations
  end

  def create
    @formation = Formation.new_by(data: params[:_json], owner: current_user)    
    if @formation.save
      expire_cache(@formation.match)
      respond_to do |format|
        render :json => { :success => true }
      end
    end
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
    respond_to do |format|
      format.html
      format.json  { render :json => @formation.as_json(
        :include => {
          :players_positions => {
            :include => {
              :player => {
                :methods => [:avatar]
              }
            }
          }
        }
      )}
    end
  end
  
  def destroy
    @formation = Formation.find(params[:id])
    expire_cache(@formation.match)
    @formation.destroy

    respond_to do |format|
      format.html { redirect_to :root, :notice => t(:formation_destroyed) }
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

private
  def formation_has_created_check
    next_match = Calendar.next_match
    if (next_match)
      if Formation.already_created?(current_user, next_match)
        flash[:notice] = t(:formation_once_per_match) 
        redirect_to '/'
      end
    end    
  end
  
  def time_limit_check
    next_match = Calendar.next_match
    if (next_match)
      if next_match.expired?
        flash[:notice] = t(:formation_time_is_over)
        redirect_to '/'
      end
    end
  end
  
  def check_exist_next_match
    next_match = Calendar.next_match
    redirect_to '/' if next_match.nil?
  end

end
