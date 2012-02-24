class PositionMappersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  # GET /position_mappers
  # GET /position_mappers.json
  def index
    @position_mappers = PositionMapper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @position_mappers }
    end
  end

  # GET /position_mappers/1
  # GET /position_mappers/1.json
  def show
    @position_mapper = PositionMapper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_mapper }
    end
  end

  # GET /position_mappers/new
  # GET /position_mappers/new.json
  def new
    @position_mapper = PositionMapper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_mapper }
    end
  end

  # GET /position_mappers/1/edit
  def edit
    @position_mapper = PositionMapper.find(params[:id])
  end

  # POST /position_mappers
  # POST /position_mappers.json
  def create
    @position_mapper = PositionMapper.new(params[:position_mapper])

    respond_to do |format|
      if @position_mapper.save
        format.html { redirect_to @position_mapper, notice: 'Position mapper was successfully created.' }
        format.json { render json: @position_mapper, status: :created, location: @position_mapper }
      else
        format.html { render action: "new" }
        format.json { render json: @position_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_mappers/1
  # PUT /position_mappers/1.json
  def update
    @position_mapper = PositionMapper.find(params[:id])

    respond_to do |format|
      if @position_mapper.update_attributes(params[:position_mapper])
        format.html { redirect_to @position_mapper, notice: 'Position mapper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_mappers/1
  # DELETE /position_mappers/1.json
  def destroy
    @position_mapper = PositionMapper.find(params[:id])
    @position_mapper.destroy

    respond_to do |format|
      format.html { redirect_to position_mappers_url }
      format.json { head :no_content }
    end
  end
end
