# Returns the name of this task.
def name
  "google_subdomain_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and creates an object for all discovered subdomains."
end

# Returns an array of valid types for this task
def allowed_types
  [Domain]
end

def setup(object, options={})
  super(object, options)
  self
end

# Default method, subclasses must override this
def run
  super

  # Attach to the google search service
  x = Ear::Client::Google::SearchService.new

  # Use the inurl: capability
  results = x.search "inurl:.#{@object.name}"

  results.each do |result|
    # Create a new domain
    o = create_object Domain, { :name => result.visible_url, 
      :organization => @object.organization }
  end

  @task_run.save_raw_result results.to_s
end

def cleanup
  super
end
