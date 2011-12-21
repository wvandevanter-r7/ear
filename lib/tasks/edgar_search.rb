require 'nokogiri'
require 'open-uri'
require 'cgi'

# Returns the name of this task.
def name
	"edgar_search"
end

# Returns a string which describes this task.
def description
	"This task hits the Corpwatch API and creates an object for all found entities."
end

# Returns an array of valid types for this task
def allowed_types
	[SearchString]
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
		# Search URI
		uri = "	http://api.corpwatch.org/companies.xml?company_name=#{@object.name}&key=#{EAR::CORPWATCH_API_KEY}"
		
		# Open page & parse
		@task_logger.log "Using Company URI: #{uri}"
		doc = Nokogiri::XML(open(search_uri, "User-Agent" => EAR::USER_AGENT_STRING))

		raise "TODO - PARSE DOC"

			# Create a new organization object
			o = create_object Organization, { :name => company_name, :sources => [company_uri] }

			# Queue a detailed search
			TaskManager.instance.queue_task_run("hoovers_company_detail",o, {})

		end
	#rescue Exception => e
	#	@task_logger.log_error "Caught Exception: #{e}"
	#end
end

def cleanup
	super
end
