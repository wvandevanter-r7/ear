class ObjectMappingsController < ApplicationController
  # GET /object_mappings
  # GET /object_mappings.json
  def index
    @object_mappings = ObjectMapping.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @object_mappings }
    end
  end

  # GET /object_mappings/1
  # GET /object_mappings/1.json
  def show
    @object_mapping = ObjectMapping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @object_mapping }
    end
  end

  # GET /object_mappings/new
  # GET /object_mappings/new.json
  def new
    @object_mapping = ObjectMapping.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @object_mapping }
    end
  end

  # GET /object_mappings/1/edit
  def edit
    @object_mapping = ObjectMapping.find(params[:id])
  end

  # POST /object_mappings
  # POST /object_mappings.json
  def create
    @object_mapping = ObjectMapping.new(params[:object_mapping])

    respond_to do |format|
      if @object_mapping.save
        format.html { redirect_to @object_mapping, notice: 'Object mapping was successfully created.' }
        format.json { render json: @object_mapping, status: :created, location: @object_mapping }
      else
        format.html { render action: "new" }
        format.json { render json: @object_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /object_mappings/1
  # PUT /object_mappings/1.json
  def update
    @object_mapping = ObjectMapping.find(params[:id])

    respond_to do |format|
      if @object_mapping.update_attributes(params[:object_mapping])
        format.html { redirect_to @object_mapping, notice: 'Object mapping was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @object_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_mappings/1
  # DELETE /object_mappings/1.json
  def destroy
    @object_mapping = ObjectMapping.find(params[:id])
    @object_mapping.destroy

    respond_to do |format|
      format.html { redirect_to object_mappings_url }
      format.json { head :ok }
    end
  end
end
