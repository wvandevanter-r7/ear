# Returns the name of this task.
def name
  "google_file_download"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and grabs all interesting file. Optionally it can download them."
end

# Returns an array of valid types for this task
def allowed_types
  [SearchString, Domain]
end

def setup(object, options={})
  super(object, options)
  self
end

def run
  super

  file_type_list = ["pdf", "doc", "xls", "ppt", "txt"] || @options['file_type_list'].split(",")

  x = Ear::Client::Google::SearchService.new

  file_type_list.each do |file_type|
    results = x.search("#{@object.name} filetype:#{file_type}")

    results.each do |result|
      puts result.title
      puts result.content
      puts result.url
    end

    @task_run.save_raw_result results.to_s
  end
end

def cleanup
  super
end
