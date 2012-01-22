require 'nokogiri'
require 'open-uri'
require 'cgi'

# Returns the name of this task.
def name
  "hoovers_company_search"
end

# Returns a string which describes this task.
def description
  "This task scrapes Hoovers and creates organizations for all companies found."
end

# Returns an array of valid types for this task
def allowed_types
  [SearchString, Organization]
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
    search_uri = "http://www.hoovers.com/search/company-search-results/100005142-1.html?type=company&term=#{@object.name}"

    # Open page & parse
    @task_logger.log "Using Company URI: #{search_uri}"
    doc = Nokogiri::HTML(open(search_uri, "User-Agent" => EAR::USER_AGENT_STRING))

    # Open the returned xhtml doc
    doc.xpath("//*[@class='company_name']").each do |xpath|

      # Construct the Company-specific URI's
      company_name = xpath.children.first['title']
      company_path = xpath.children.first['href']
      company_uri = "http://www.hoovers.com#{company_path}"
      @task_logger.log "Using Company search URI: #{company_uri}"

      # Create a new organization object
      o = create_object(Organization, { :name => company_name, :sources => [company_uri] })

      # Queue a detailed search
      TaskManager.instance.queue_task_run("hoovers_company_detail",o, {})

    end
  #rescue Exception => e
  #  @task_logger.log_error "Caught Exception: #{e}"
  #end
end

def cleanup
  super
end
