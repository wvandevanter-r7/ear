require 'resolv'

def name
	"dns_reverse_lookup"
end

def description
	"Reverse DNS Lookup"
end

## Returns an array of valid types for this task
def allowed_types
	[Host]
end

def setup(object, options={})
	super(object, options)
end

def run
	super

	name = Resolv.new.getname(@object.ip_address).to_s
	if name
		# Set our hostname
		@object.name = name
		@object.save!
		# Create a new domain object
		@task_logger.log_good "Creating domain #{name}"
		create_object(Domain, {:name => name})
	else
		@task_logger.log_error "Unable to find a name"
	end
end

def cleanup
	super
end

