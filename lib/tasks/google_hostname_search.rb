# Returns the name of this task.
def name
  "google_hostname_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and creates an object for all discovered hostnames."
end

# Returns an array of valid types for this task
def allowed_types
  [SearchString, Organization, Domain]
end

def setup(object, options={})
  super(object, options)
  self
end

# Default method, subclasses must override this
def run
  super

  # Attach to the corpwatch service & search
  x = Ear::Client::Google::SearchService.new
  results = x.search @object.name

  results.each do |result|
    # Create a new organization object & attach a record
    o = create_object Domain, { :name => result.visible_url }
  end

  @task_run.save_raw_result results.to_s
end

def cleanup
  super
end
