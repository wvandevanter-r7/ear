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

  # Attach to the first object
  create_object(PhysicalLocation, {:address => corps.first.address, :state => corps.first.state, :country => corps.first.country })
  #create_object(Record, {:name => "edgar_detail", :object_type => corp.class.to_s, :content => corp})
end

def cleanup
  super
end
