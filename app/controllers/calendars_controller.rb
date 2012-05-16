class CalendarsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:index, :formations_matches]
  respond_to :json, :html
  
  def formations_matches
    @match = Calendar.find(params[:id])
    if @match.nil?
      redirect_to '/'
    end
  end
  
  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.sort(:day.asc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  # GET /calendars/new.json
  def new
    @teams = Team.sort(:name)
    @calendar = Calendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
    @teams = Team.sort(:name)
    @calendar = Calendar.find(params[:id])
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(params[:calendar])

    respond_to do |format|
      if @calendar.save
        expire_cache(@calendar)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar, status: :created, location: @calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendars/1
  # PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        expire_cache(@calendar)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar = Calendar.find(params[:id])
    expire_cache(@calendar)
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url }
      format.json { head :no_content }
    end
  end
end
