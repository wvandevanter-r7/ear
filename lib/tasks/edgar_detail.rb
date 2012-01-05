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

	x = Corpwatch::CorpwatchService.new
	corps = x.search @object.name

	# Select the first corp & add the details
	@object.address =  corps.first.address
	@object.description = corps.first.industry_name
	@object.state = corps.first.state
	@object.country = corps.first.country

	Record.new :name => "EDGAR", :content => corp, :organization => @object

end

def cleanup
	super
end
