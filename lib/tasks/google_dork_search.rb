# Returns the name of this task.
def name
  "google_dork_search"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and searches for common googledorks."
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
  
  dork_strings = ["filetype:xls","filetype:doc", "filetype:asp"]
  
  dork_strings.each do |dork|

    # do the actual search
    results = x.search "#{dork} inurl:#{@object.name}" 

    results.each do |result|
      # For now, just stick it on the task object - creating a specific object
      # is gonna take a little more thought
      @task_run.save_raw_result result.to_s
    end
  end

end

def cleanup
  super
end
