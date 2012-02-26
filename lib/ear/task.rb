class Task

  # Rails model compatibility #
  def self.all
    TaskManager.instance.tasks
  end

  def self.find(name)
    TaskManager.instance.find_task name
  end
  
  def self.model_name
    "task"
  end 

  def self.id
    return self.name
  end
  # End Rails compatibility #
 
  attr_accessor :task_logger

  # Maintain a constructor that takes no options - all code will be eval'd in
  def initialize
    @task_logger = TaskLogger.new name
  end

  def underscore
    "task"
  end

  # Returns an array of valid types for this task
  def allowed_types
    []
  end

  def name
    "Generic Task"
  end
  
  def description
    "This is a generic task"
  end

  #
  # Where the pre-run setup happens
  #
  def setup(object, options={})  
    @object = object
    @options = options

    @task_run = TaskRun.create(
      :name => name,
      :type => nil,
      :task_object_type => @object.class.to_s,
      :task_object_id => @object.id, 
      :task_options_hash => @options )

    #
    # This is an AR relationship, so we can go back and access all tasks for 
    # a particular object.
    #
    @object.task_runs << @task_run

    @task_logger.log "Task object: #{@object}"
    @task_logger.log "Task options: #{@options}"
    @task_logger.log "Task run: #{@task_run}"
  end
  
  # Override
  def run
  end
  
  # Basic cleanup method
  def cleanup
  end
  
  # Checks for validity
  def valid?
  end
  
  def to_s
    "#{name}: #{description}"
  end


  def safe_system(command)
    @task_logger.log_error "UNSAFE SYSTEM CALL DUDE."
  
    if command =~ /(\||\;)/
      raise "Illegal character"
    end
    
    `#{command}`
  end

  #
  # Convenience method that makes it easy to create
  # objects from within a task. designed to simplify the 
  # task api. do not override.
  #
  # current_object keeps track of the current object which we're associating with
  # params are params for creating the new object
  #  new_object keeps track of the new object
  #
  def create_object(type, params, current_object=@object)
    @task_logger.log "Creating new object of type: #{type}"

    # Call the create method for this type
    new_object = type.send(:create, params)

    # Check for dupes & return right away if this doesn't save a new
    # object. This should prevent the object mapping from getting created.
    if new_object.save
      @task_logger.log_good "Created new object: #{new_object}"
    else
      @task_logger.log "Could not save object, are you sure it's valid & doesn't already exist?"
      new_object = find_object type, params
    end

    # If we have a new object, then we should keep track of the information
    # that created this object
    @task_logger.log "Associating #{current_object} with #{new_object}"
    current_object.associate_child({:child => new_object, :task_run => @task_run})
  new_object
  end

  # ooh, this is dangerous metamagic. -- would need to be revisited if we do 
  # something weird with the models. for now, it should be sufficent to generally
  # send "name" and special case anything else.
  def find_object(type, params)
    if type == Host
      return Host.find_by_ip_address params[:ip_address]
    else
      if params.has_key? :name
        return type.send(:find_by_name, params[:name])
      else
        raise "Don't know how to find this object of type #{type}"
      end
    end
  end


  # 
  # Run the task. Convenience method. Do not override
  #
  def execute(object, options={})
    
    EarLogger.instance.log "Running task: #{self.name}"
    EarLogger.instance.log "Object: #{object}"
    EarLogger.instance.log "Options: #{options}"

    self.setup(object, options)
    self.run
    self.cleanup

  true
  end

end
