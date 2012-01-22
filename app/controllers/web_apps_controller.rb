class WebAppsController < ApplicationController
  # GET /web_apps
  # GET /web_apps.json
  def index
    @web_apps = WebApp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @web_apps }
    end
  end

  # GET /web_apps/1
  # GET /web_apps/1.json
  def show
    @web_app = WebApp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @web_app }
    end
  end

  # GET /web_apps/new
  # GET /web_apps/new.json
  def new
    @web_app = WebApp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @web_app }
    end
  end

  # GET /web_apps/1/edit
  def edit
    @web_app = WebApp.find(params[:id])
  end

  # POST /web_apps
  # POST /web_apps.json
  def create
    @web_app = WebApp.new(params[:web_app])

    respond_to do |format|
      if @web_app.save
        format.html { redirect_to @web_app, notice: 'Web app was successfully created.' }
        format.json { render json: @web_app, status: :created, location: @web_app }
      else
        format.html { render action: "new" }
        format.json { render json: @web_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /web_apps/1
  # PUT /web_apps/1.json
  def update
    @web_app = WebApp.find(params[:id])

    respond_to do |format|
      if @web_app.update_attributes(params[:web_app])
        format.html { redirect_to @web_app, notice: 'Web app was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_apps/1
  # DELETE /web_apps/1.json
  def destroy
    @web_app = WebApp.find(params[:id])
    @web_app.destroy

    respond_to do |format|
      format.html { redirect_to web_apps_url }
      format.json { head :ok }
    end
  end
end
