require 'singleton'
require 'find'

class TaskManager

	include Singleton
	include Enumerable 

	cattr_accessor :tasks
	cattr_accessor :tasks_dir
	
	def initialize(path=nil)
		@@tasks_dir = path || File.join(File.dirname(__FILE__), "..", "tasks")
		@@task_files = []
		@@tasks = []
	
	  load_tasks(@@tasks_dir)
	end

	#
	# This method allows us to act like an enumerator
	#
	def [](x)
		return @@tasks[x]
	end
	
	# 
	# This method allows us to reload our tasks
	#
	def reload_tasks(dir=@@tasks_dir)
	  @@task_files = []
	  load_tasks(dir)
	end
	
	# 
	# This method loads our task files from disk
	#
	def load_tasks(dir=@@tasks_dir)
	  Dir.entries(dir).each do |entry| 
			# Check for obvious directories
			if !(entry =~ /^\./) 
				# Make sure it's a file
				if File.file? dir + "/" + entry 
					# Toss it in our array		
					@@task_files << dir + "/" + entry 
				end
			end
		end
		
		@@task_files.each do |task_file|
			task_data=[]			
			File.open(task_file, "r").each { |line|	task_data << line }
 		  t = Task.new
			t.instance_eval(task_data.join("\n"))
			@@tasks << t
		end
	end
	
	#
	# Given an object, return all tasks that can operate on that object 
	#
	def get_tasks_for(object)
		tasks_for_type = []

		@@tasks.each do |task|
			if task.allowed_types.include?(object.class)
				tasks_for_type << task
			end
		end
		
		tasks_for_type
	end
	
	# 
	# Run a task on an object
	#
	def run_task(name, object, options={})
		## TODO - multithread
				
		EarLogger.instance.log_good "Task manager running task: #{name}"
		EarLogger.instance.log_good "Object: #{object}"
		EarLogger.instance.log_good "Options: #{options}"
		
		## TODO - catch invalid tasks here!
			@@tasks.each do |task|
				if task.name.downcase == name.downcase
					#Thread.new do
						task.setup(object, options)
						task.run
						task.cleanup
					#end
				end
			end

	return object
  end
	
end
