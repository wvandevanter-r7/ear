require 'nokogiri'
require 'open-uri'
require 'cgi'

# Returns the name of this task.
def name
	"edgar_info"
end

# Returns a string which describes this task.
def description
	"This task hits the corpwatch API and creates organizations for all companies found."
end

# Returns an array of valid types for this task
def allowed_types
	[Organization]
end

def setup(object, options={})
	super(object, options)
	self
end

# Default method, subclasses must override this
def run
	super

	# Wrap the whole thing in a begin, we could have URI's switched beneath us. 
	#begin

	raise "TODO - GET & PARSE DOC"

	#rescue Exception => e
	#	@task_logger.log_error "Caught Exception: #{e}"
	#end
end

def cleanup
	super
end
