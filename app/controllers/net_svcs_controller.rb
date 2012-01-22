class NetSvcsController < ApplicationController
  # GET /net_svcs
  # GET /net_svcs.json
  def index
    @net_svcs = NetSvc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @net_svcs }
    end
  end

  # GET /net_svcs/1
  # GET /net_svcs/1.json
  def show
    @net_svc = NetSvc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @net_svc }
    end
  end

  # GET /net_svcs/new
  # GET /net_svcs/new.json
  def new
    @net_svc = NetSvc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @net_svc }
    end
  end

  # GET /net_svcs/1/edit
  def edit
    @net_svc = NetSvc.find(params[:id])
  end

  # POST /net_svcs
  # POST /net_svcs.json
  def create
    @net_svc = NetSvc.new(params[:net_svc])

    respond_to do |format|
      if @net_svc.save
        format.html { redirect_to @net_svc, notice: 'Net svc was successfully created.' }
        format.json { render json: @net_svc, status: :created, location: @net_svc }
      else
        format.html { render action: "new" }
        format.json { render json: @net_svc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /net_svcs/1
  # PUT /net_svcs/1.json
  def update
    @net_svc = NetSvc.find(params[:id])

    respond_to do |format|
      if @net_svc.update_attributes(params[:net_svc])
        format.html { redirect_to @net_svc, notice: 'Net svc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @net_svc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /net_svcs/1
  # DELETE /net_svcs/1.json
  def destroy
    @net_svc = NetSvc.find(params[:id])
    @net_svc.destroy

    respond_to do |format|
      format.html { redirect_to net_svcs_url }
      format.json { head :ok }
    end
  end
end
