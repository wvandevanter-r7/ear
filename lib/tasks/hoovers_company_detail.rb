require 'nokogiri'
require 'open-uri'
require 'cgi'

# Returns the name of this task.
def name
	"hoovers_company_detail"
end

# Returns a string which describes this task.
def description
	"This task scrapes Hoovers for specific details about the organization."
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
	# Wrap the whole thing in a begin, we could have URI's switched
	# underneath us. 
	begin
		# construct a searchable name - TODO urlencode?
		temp_name = @object.name.gsub(" ","%20")
		
		# Search URI
		search_uri = "http://www.hoovers.com/search/company-search-results/100005142-1.html?type=company&term=#{temp_name}"
		
		# Open page & parse
		@task_logger.log "Using Company URI: #{search_uri}"
		doc = Nokogiri::HTML(open(search_uri))

		# Use the first result from this search. If we've done the hoover's company
		# Search first, then we should be able to simply query for the company name
		# and use the first result
		xpath = doc.xpath("//*[@class='company_name']").first

			# Construct the Company-specific URI's
			company_path = xpath.children.first['href']
			company_uri = "http://www.hoovers.com#{company_path}"
			@task_logger.log "Using Company search URI: #{company_uri}"
		
			# Wrap this section in a begin, because Hoovers may list a company
			# that no longer exists. We don't want to bomb out of the task for 
			# one lousy missing company.
			begin
				# Grab the company-specific URI
				doc = Nokogiri::HTML(open(company_uri))

				# Get Address & Clean up
				street_address = Nokogiri::XML((doc/"/html/body/div[2]/div[2]/table/tbody/tr/td/strong/span").to_xml).text
				@task_logger.log_good "Got Street Address: #{street_address}"

				city_state = Nokogiri::XML((doc/"/html/body/div[2]/div[2]/table/tbody/tr[2]/td/strong/span").to_xml).text
				@task_logger.log_good "Got City & State: #{city_state}"

				# Set the City and State
				@object.street_address = street_address
				@object.city = city_state.split(' ').first
				@object.state = city_state.split(' ').last

				# Get Users from the executive table
				(doc/"//*[@id=\"executivetable\"]").css('td').each do |user_line| 

					# Select the name from the row
					user_line.inner_text.gsub!("&#xa0;"," ")
					full_name = user_line.inner_text unless /E-mail/ =~ user_line.inner_text 

					# Split up the name
					first_name,last_name = full_name.split(' ')

					# Create the user objects
					@task_logger.log_good "Adding user object for: #{full_name}"
					create_object User, { :first_name => first_name, :last_name => last_name }
				end
	
				# Get Company Profile set this
				description = Nokogiri::XML((doc/"/html/body/div[3]/div[2]/div[7]/p").to_xml).text

			rescue Exception => e
				@task_logger.log_error "Caught Exception: #{e}"
			end
		#end		
	rescue Exception => e
		@task_logger.log_error "Caught Exception: #{e}"
	end
end

def cleanup
	super
end
