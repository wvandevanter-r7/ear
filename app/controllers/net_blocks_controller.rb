class NetBlocksController < ApplicationController
  # GET /net_blocks
  # GET /net_blocks.json
  def index
    @net_blocks = NetBlock.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @net_blocks }
    end
  end

  # GET /net_blocks/1
  # GET /net_blocks/1.json
  def show
    @net_block = NetBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @net_block }
    end
  end

  # GET /net_blocks/new
  # GET /net_blocks/new.json
  def new
    @net_block = NetBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @net_block }
    end
  end

  # GET /net_blocks/1/edit
  def edit
    @net_block = NetBlock.find(params[:id])
  end

  # POST /net_blocks
  # POST /net_blocks.json
  def create
    @net_block = NetBlock.new(params[:net_block])

    respond_to do |format|
      if @net_block.save
        format.html { redirect_to @net_block, notice: 'Net block was successfully created.' }
        format.json { render json: @net_block, status: :created, location: @net_block }
      else
        format.html { render action: "new" }
        format.json { render json: @net_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /net_blocks/1
  # PUT /net_blocks/1.json
  def update
    @net_block = NetBlock.find(params[:id])

    respond_to do |format|
      if @net_block.update_attributes(params[:net_block])
        format.html { redirect_to @net_block, notice: 'Net block was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @net_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /net_blocks/1
  # DELETE /net_blocks/1.json
  def destroy
    @net_block = NetBlock.find(params[:id])
    @net_block.destroy

    respond_to do |format|
      format.html { redirect_to net_blocks_url }
      format.json { head :ok }
    end
  end
end
