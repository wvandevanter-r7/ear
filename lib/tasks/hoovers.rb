require 'nokogiri'
require 'open-uri'
require 'cgi'

def name
	"hoovers"
end

## Returns a string which describes what this task does
def description
	"This task scrapes Hoovers for company info."
end

## Returns an array of valid types for this task
def allowed_types
	return [Organization]
end

def setup(object, options={})
	super(object, options)
  self
end

## Default method, subclasses must override this
def run
  super
    
  # Search URI
  search_uri = "http://www.hoovers.com/search/company-search-results/100005142-1.html?type=company&term=#{@object.name}"

	# Open page & parse
	@task_logger.log "Using Company URI: #{search_uri}"
  doc = Nokogiri::HTML(open(search_uri))

	# Open the doc
  company_path = doc.xpath("//*[@class='company_name']").first.children.first['href']
  company_uri = "http://www.hoovers.com#{company_path}"
  
  # Open Page & Parse
	@task_logger.log "Using Search URI: #{company_uri}"
	doc = Nokogiri::HTML(open(company_uri))
  
  # Get Company Profile
  # TODO
   
  # Get Address & Clean up
  address = (doc/"/html/body/div[3]/div[2]/table/tbody/tr/td/strong/span").inner_html
  @task_logger.log_good "Got Address: #{address}"
    
  # Get Users
  user = (doc/"/html/body/div[3]/div[2]/div[9]/table/tbody/tr/td").inner_html

  unless user.blank?
		# Do some cleanup
		names = user.gsub("a href=\"/marketing/free-trial/100004836-1.html\" title=\"Email lists, email contacts, contact phone numbers, email leads, phone leads\" relatedarticles=\"false\" id=\"100004836\">E-mail</a>","").split("<") 
    @task_logger.log_good "Got Users: #{names.join(" ")}"
  
		# Parse out the names
    names.each do |name| 
    	@task_logger.log_good "Adding user object for: #{name}"
			name.gsub!("&nbsp;"," ")
      first_name,last_name = name.split(" ")

			# Create the user objects
      create_object User, { :first_name => first_name, :last_name => last_name }
    end
  end
end

def cleanup
	super
end
