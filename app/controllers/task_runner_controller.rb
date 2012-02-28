class TaskRunnerController < ApplicationController
  def run

    @selected_objects_and_ids = params['objects']
    task_name = params['task_name']
    @objects = []

    # TODO - flash error?
    return unless @task
    return unless @selected_objects_and_ids

    @selected_objects_and_ids.each do |object_and_id|
      object,id = object_and_id.first.split("#")
        x = eval(object.capitalize) 
        @objects << x.find(id) if x
    end

    @task_runs = []
    # Run the task on each object
    @objects.each do |o|
      @task_runs << o.run_task(task_name)
    end
    
    #redirect_to :action => "view"
  end

  def view
    @task_runs
  end

end
