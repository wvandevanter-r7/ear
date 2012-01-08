class PhysicalLocationsController < ApplicationController
  # GET /physical_locations
  # GET /physical_locations.json
  def index
    @physical_locations = PhysicalLocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @physical_locations }
    end
  end

  # GET /physical_locations/1
  # GET /physical_locations/1.json
  def show
    @physical_location = PhysicalLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @physical_location }
    end
  end

  # GET /physical_locations/new
  # GET /physical_locations/new.json
  def new
    @physical_location = PhysicalLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @physical_location }
    end
  end

  # GET /physical_locations/1/edit
  def edit
    @physical_location = PhysicalLocation.find(params[:id])
  end

  # POST /physical_locations
  # POST /physical_locations.json
  def create
    @physical_location = PhysicalLocation.new(params[:physical_location])

    respond_to do |format|
      if @physical_location.save
        format.html { redirect_to @physical_location, notice: 'Physical location was successfully created.' }
        format.json { render json: @physical_location, status: :created, location: @physical_location }
      else
        format.html { render action: "new" }
        format.json { render json: @physical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /physical_locations/1
  # PUT /physical_locations/1.json
  def update
    @physical_location = PhysicalLocation.find(params[:id])

    respond_to do |format|
      if @physical_location.update_attributes(params[:physical_location])
        format.html { redirect_to @physical_location, notice: 'Physical location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @physical_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /physical_locations/1
  # DELETE /physical_locations/1.json
  def destroy
    @physical_location = PhysicalLocation.find(params[:id])
    @physical_location.destroy

    respond_to do |format|
      format.html { redirect_to physical_locations_url }
      format.json { head :ok }
    end
  end
end
