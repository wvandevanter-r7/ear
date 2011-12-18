	require 'resolv'

	def name
		"forward_lookup"
	end

	## Returns a string which describes what this task does
	def description
		"Forward DNS Lookup"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Host, Domain]
	end
	
	def setup(object, options={})
		super(object, options)
	end

	def run
		super

	  #begin
			# Handle Host object
			if @object.kind_of?(Host)
				if @object.name
					resolved_address = Resolv.new.getaddress(@object.name)
					@object.name = resolved_address
					@object.save!					
				end
			# Handle Domain object
			elsif @object.kind_of?(Domain)
				resolved_address = Resolv.getaddress(@object.name)
				@task_logger.log_good "Creating host object for #{resolved_address}"				
				h = create_object Host, {:ip_address => resolved_address, :name => @object.name}
			end		
		#rescue Exception => e
		#	@task_logger.log_error "Unable to lookup: #{e}"
		#end
	end

	def cleanup
		super
	end
