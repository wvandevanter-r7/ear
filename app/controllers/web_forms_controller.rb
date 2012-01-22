class WebFormsController < ApplicationController
  # GET /web_forms
  # GET /web_forms.json
  def index
    @web_forms = WebForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @web_forms }
    end
  end

  # GET /web_forms/1
  # GET /web_forms/1.json
  def show
    @web_form = WebForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @web_form }
    end
  end

  # GET /web_forms/new
  # GET /web_forms/new.json
  def new
    @web_form = WebForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @web_form }
    end
  end

  # GET /web_forms/1/edit
  def edit
    @web_form = WebForm.find(params[:id])
  end

  # POST /web_forms
  # POST /web_forms.json
  def create
    @web_form = WebForm.new(params[:web_form])

    respond_to do |format|
      if @web_form.save
        format.html { redirect_to @web_form, notice: 'Web form was successfully created.' }
        format.json { render json: @web_form, status: :created, location: @web_form }
      else
        format.html { render action: "new" }
        format.json { render json: @web_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /web_forms/1
  # PUT /web_forms/1.json
  def update
    @web_form = WebForm.find(params[:id])

    respond_to do |format|
      if @web_form.update_attributes(params[:web_form])
        format.html { redirect_to @web_form, notice: 'Web form was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_forms/1
  # DELETE /web_forms/1.json
  def destroy
    @web_form = WebForm.find(params[:id])
    @web_form.destroy

    respond_to do |format|
      format.html { redirect_to web_forms_url }
      format.json { head :ok }
    end
  end
end
