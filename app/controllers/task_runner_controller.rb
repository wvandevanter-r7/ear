class TaskRunnerController < ApplicationController
  def run

    #
    # Get our params
    #
    @selected_objects_and_ids = params['objects']
    task_name = params['task_name']

    #
    # If we don't have reasonable input, return
    #
    # TODO - flash error?
    return unless task_name
    return unless @selected_objects_and_ids

    #
    # Create the objects based on the params
    #
    @objects = []
    @selected_objects_and_ids.each do |object_and_id|
      object,id = object_and_id.first.split("#")
        x = eval(object.capitalize) 
        @objects << x.find(id) if x
    end

    #
    # Run the task on each object
    #
    @results = []
    @objects.each do |o|
      #
      # Run the task
      #
      @results << o.run_task(task_name)
    end
    
    @task = Task.find task_name
    render :action => "view"
  end

  def view
  end

end
