module ModelHelper

	def self.included(base)
    base.class_eval do

			#
			# This method lets you query the available tasks for this object type
			#
			def tasks
				TaskManager.instance.get_tasks_for(self)
			end

			#
			# This method lets you run a task on this object
			#
			def run_task(task)
				TaskManager.instance.run_task(task,self)
			end

			#
			# This method lets you find all available children
			#
			def children
				ObjectManager.instance.find_children(self.id, self.class.to_s)
			end

			#
			# This method lets you find all available parents
			#
			def parents
				ObjectManager.instance.find_parents(self.id, self.class.to_s)
			end
			
			#
			# This method associates a child with this object
			#
			def associate_child(params)
				new_object = params[:child]
				
				task_run = params[:task_run]

				EarLogger.instance.log_good "Associating #{self} with child object #{new_object}"

			  # grab the object's class
			  class_name = new_object.class.to_s.downcase
				
				# see if we have a collection of these things and add it if 
				#  we do.       
=begin				
				begin 
					if eval("self.#{class_name}s")
						EarLogger.instance.log_good "Adding #{new_object} to #{self}"
						# If so, then add it to the collection
						eval "self.#{class_name}s << object"
					# if not, try to associate a singular object
		      elsif eval("self.#{class_name}")
						EarLogger.instance.log_good "Setting #{new_object}.#{class_name} to #{self}"
						# Set it 
						eval "self.#{class_name}.id=object.id"
					else
						EarLogger.instance.log_good "Simply associating, not adding to the collection"			
				  end
				rescue
					EarLogger.instance.log_debug "self.#{class_name} doesn't exist, caught."
				end
=end
				# And set us up as a parent through an object_mapping
				# new_object._map_parent(params)  
			 	# And associate the object as a child through an object_mapping
				_map_child(params)
		  end
			
			# 
			# This method returns a pretty print version of the relationships
			#  of this object
			# 
    	def to_graph(indent=nil)
    	  out = "Parents: "
    	  self.parents.each { |parent| out += " #{parent}" }
        out += "\nObject: #{self.to_s}\n"
    	  out += "Children: "
    	  self.children.each { |child| out += " #{child}" }
        return out
      end

=begin
			# Don't call this method directly, use associate
			def _map_parent(params)			
				EarLogger.instance.log "Creating new parent mapping: #{params[:child]} => #{self}"
				ObjectMapping.create( 	
					:parent_id => params[:child].id,
					:parent_type => params[:child].class.to_s,
					:child_id => self.id,
					:child_type => self.class.to_s,
					:task_run_id => params[:task_run].id || nil)
			end
=end	
			def _map_child(params)
				EarLogger.instance.log "Creating new child mapping #{self} => #{params[:child]}"
				ObjectMapping.create(
					:parent_id => self.id,
					:parent_type => self.class.to_s,
					:child_id => params[:child].id,
					:child_type => params[:child].class.to_s,
					:task_run_id => params[:task_run].id || nil)			
			end
		end
	end
end
