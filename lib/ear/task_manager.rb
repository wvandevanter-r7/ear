require 'singleton'

class TaskManager
  include Singleton

  attr_accessor :tasks
  attr_accessor :tasks_dir
  
  def initialize(path=nil)
    @tasks_dir = path || File.join(File.dirname(__FILE__), "..", "tasks")
    @task_files = []
    @tasks = []
    @queue = RunnableTaskQueue.new
  
    #load_tasks(@tasks_dir)

    #
    # Load up a new thread to run a background tasks
    #
    #Thread.new do
    #  while true
    #    if @queue.has_tasks?
    #      object, task, options = @queue.shift
    #      task.execute(object,options)
    #    end
    #    sleep 1
    #  end
    #end
  end

  def find_by_name(task_name)
    return _get_task_by_name(task_name)
  end

  # 
  # This method allows us to reload our tasks
  #
  def reload_tasks(dir=@tasks_dir)
    @task_files = []
    load_tasks(dir)
  end
  
  # 
  # This method loads our task files from disk
  #
  def load_tasks(dir=@tasks_dir)
    @task_files = []
    Dir.entries(dir).each do |entry| 
      #
      # Check for obvious directories
      #
      if !(entry =~ /^\./)
        #
        # Make sure it's a file
        #
        if File.file? dir + "/" + entry 
          #
          # Toss it in our array
          #
          @task_files << dir + "/" + entry 
        end
      end
    end
    
    #
    # For each of our identified task files...
    #
    @task_files.each do |task_file|
      #
      # Create a new task and eval our task into it
      #
      EarLogger.instance.log "Evaluating task: #{task_file}"
      t = Task.new
      t.instance_eval(File.open(task_file, "r").read)

      #
      # Add it to our task listing
      #
      @tasks << t
    end
  end
  
  #
  # Given an object, return all tasks that can operate on that object 
  #
  def get_tasks_for(object)
    tasks_for_type = []

    @tasks.each do |task|
      if task.allowed_types.include?(object.class)
        tasks_for_type << task
      end
    end

    tasks_for_type
  end

  # This method will be called by the objects 
  def queue_task_run(task_name, object, options)

    # Make note of the fact that we're shipping this off to the queue
    EarLogger.instance.log "Task manager queueing task: #{task_name} for object #{object} with options #{options}"

    # Add it to the run queue
    return @queue.add_task_run(object, task_name, options)
  end

private
  # This method is used to translate task names into task objects
  def _get_task_by_name(task_name)
    @tasks.each do |t|
      return t if t.name == task_name
    end
    raise "Unknown Task!"  # couldn't find it. boo.
  end
end
