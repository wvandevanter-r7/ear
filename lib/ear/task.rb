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

		@task_logger.log_good "Task object: #{@object}"
		@task_logger.log_good "Task options: #{@options}"
		@task_logger.log_good "Task run: #{@task_run}"
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
	
	## Convenience method that makes it easy to create
	## objects from within a task. designed to simplify the 
	## task api. do not override.
	def create_object(type, params)
		@task_logger.log_good("Creating new object of type: #{type}")

		# Call the create method for this type
		new_object = type.send(:create, params)

		# Check for dupes
		return @task_logger.log_bad("Error creating object") if !new_object.save
		@task_logger.log_good("Created new object: #{new_object}")

		## Keep track of the information that created this object
		@task_logger.log_good("Associating #{@object} with #{new_object}")
		@object.associate_child({:child => new_object, :task_run => @task_run})
	end

end
