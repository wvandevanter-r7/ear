class TaskResultsController < ApplicationController
  # GET /task_results
  # GET /task_results.json
  def index
    @task_results = TaskResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_results }
    end
  end

  # GET /task_results/1
  # GET /task_results/1.json
  def show
    @task_result = TaskResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_result }
    end
  end

  # GET /task_results/new
  # GET /task_results/new.json
  def new
    @task_result = TaskResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_result }
    end
  end

  # GET /task_results/1/edit
  def edit
    @task_result = TaskResult.find(params[:id])
  end

  # POST /task_results
  # POST /task_results.json
  def create
    @task_result = TaskResult.new(params[:task_result])

    respond_to do |format|
      if @task_result.save
        format.html { redirect_to @task_result, notice: 'Task result was successfully created.' }
        format.json { render json: @task_result, status: :created, location: @task_result }
      else
        format.html { render action: "new" }
        format.json { render json: @task_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_results/1
  # PUT /task_results/1.json
  def update
    @task_result = TaskResult.find(params[:id])

    respond_to do |format|
      if @task_result.update_attributes(params[:task_result])
        format.html { redirect_to @task_result, notice: 'Task result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_results/1
  # DELETE /task_results/1.json
  def destroy
    @task_result = TaskResult.find(params[:id])
    @task_result.destroy

    respond_to do |format|
      format.html { redirect_to task_results_url }
      format.json { head :ok }
    end
  end
end
