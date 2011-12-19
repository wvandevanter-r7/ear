class SearchStringsController < ApplicationController
  # GET /search_strings
  # GET /search_strings.json
  def index
    @search_strings = SearchString.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @search_strings }
    end
  end

  # GET /search_strings/1
  # GET /search_strings/1.json
  def show
    @search_string = SearchString.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search_string }
    end
  end

  # GET /search_strings/new
  # GET /search_strings/new.json
  def new
    @search_string = SearchString.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search_string }
    end
  end

  # GET /search_strings/1/edit
  def edit
    @search_string = SearchString.find(params[:id])
  end

  # POST /search_strings
  # POST /search_strings.json
  def create
    @search_string = SearchString.new(params[:search_string])

    respond_to do |format|
      if @search_string.save
        format.html { redirect_to @search_string, notice: 'Search string was successfully created.' }
        format.json { render json: @search_string, status: :created, location: @search_string }
      else
        format.html { render action: "new" }
        format.json { render json: @search_string.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /search_strings/1
  # PUT /search_strings/1.json
  def update
    @search_string = SearchString.find(params[:id])

    respond_to do |format|
      if @search_string.update_attributes(params[:search_string])
        format.html { redirect_to @search_string, notice: 'Search string was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @search_string.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_strings/1
  # DELETE /search_strings/1.json
  def destroy
    @search_string = SearchString.find(params[:id])
    @search_string.destroy

    respond_to do |format|
      format.html { redirect_to search_strings_url }
      format.json { head :ok }
    end
  end
end
