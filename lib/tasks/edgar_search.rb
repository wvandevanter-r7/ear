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

	# Attach to the corpwatch service & search
	x = Corpwatch::CorpwatchService.new
	corps = x.search @object.name

	corps.each do |corp|
		# Create a new organization object & attach a record
		o = create_object Organization, { 
			:name => corp.name, 
			:address => corp.address, 
			:state => corp.state,
			:country => corp.country
			}
		Record.new :name => "EDGAR", :content => corp, :organization => o
	end

	# Queue a detailed search
	TaskManager.instance.queue_task_run("hoovers_company_detail",o, {})
end

def cleanup
	super
end
