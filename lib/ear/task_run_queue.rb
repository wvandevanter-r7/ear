class RunnableTaskQueue
  include Enumerable
  def add_task_run(object, task_name, options)
    
    # Get the actual task
    task = TaskManager.instance.find_by_name(task_name)
    x = task.execute(object,options)    
    
  x
  end

end
