class ObjectsController < ApplicationController
  # GET /objects
  # GET /objects.json
  def index
    @objects = Object.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @objects }
    end
  end
end
