class Task

  ## Rails compatibility ##
  def self.all
    TaskManager.tasks
  end

	def self.first
    TaskManager.tasks[0]
	end

  def self.find(num)
    TaskManager.tasks[num]
  end
  ## End Rails compatibility ##

	attr_accessor :task_logger

	# Maintain a constructor that takes no options - all code will be eval'd in
	def initialize
		@task_logger = TaskLogger.new name
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
		
	# Where the pre-run setup happens
	def setup(object, options={})	
		@object = object
		@options = options

		@task_run = TaskRun.create(
			:name => name,
			:task_object_type => @object.class.to_s,
			:task_object_id => @object.id, 
			:task_options_hash => @options )

		@task_logger.log "Task object: #{@object}"
		@task_logger.log "Task options: #{@options}"
		@task_logger.log "Task run: #{@task_run}"
	end
	
	# Override!
	def run

	end
	
	# Basic cleanup method
	def cleanup

	end
	
	## Checks for validity
	def valid?
		return true
	end
	
	def to_s
		"#{name}: #{description}"
	end

	#
	# Convenience method that makes it easy to create
	# objects from within a task. designed to simplify the 
	# task api. do not override.
	#
	# current_object keeps track of the current object which we're associating with
	# params are params for creating the new object
	#	new_object keeps track of the new object
	#
	def create_object(type, params, current_object=@object)
		@task_logger.log "Creating new object of type: #{type}"

		# Call the create method for this type
		new_object = type.send(:create, params)

		# Check for dupes / Log
		if new_object
			@task_logger.log_good "Created new object: #{new_object}"
		else
			@task_logger.log "Could not save object, perhaps it already exists?"
			return false
		end

		## Keep track of the information that created this object
		@task_logger.log "Associating #{current_object} with #{new_object}"
		current_object.associate_child({:child => new_object, :task_run => @task_run})
	new_object
	end

	# 
	# Run the task. Convenience method. Do not override
	#
	def execute(object, options={})
		
		EarLogger.instance.log "Running task: #{self.name}"
		EarLogger.instance.log "Object: #{object}"
		EarLogger.instance.log "Options: #{options}"

		#begin
			self.setup(object, options)
			self.run
			self.cleanup
		#rescue Exception => e
		#	EarLogger.instance.log_error "Error running: #{e}"
		#	return false
		#end

	return true
	end

end
