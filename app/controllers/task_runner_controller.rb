class TaskRunnerController < ApplicationController
  def run
    @selected_objects_and_ids = params['objects']
    @task = params['task_name']
    @objects = []
    
    return unless @task
    
    @selected_objects_and_ids.each do |object_and_id|
      object,id = object_and_id.first.split("#")
        x = eval(object.capitalize) 
        @objects << x.find(id) if x
    end
    
    @objects.each do |o|
      o.run_task @task
    end

  end

end
