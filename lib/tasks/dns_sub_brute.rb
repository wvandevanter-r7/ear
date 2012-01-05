require 'resolv'

def name
	"dns_sub_brute"
end

# Returns a string which describes what this task does
def description
	"Simple DNS Subdomain Bruteforce"
end

# Returns an array of valid types for this task
def allowed_types
	[Domain]
end

def setup(object, options={})
	super(object, options)
	self
end

## Default method, subclasses must override this
def run
	super

	## Read the TLD List and pre-process it to remove crud
	#f = File.open Rails.root + "data/subdomain.list"
	#subdomain_list_with_comments = f.read
	#subdomain_list = []
	#subdomain_list_with_comments.each_line {|line| subdomain_list << line unless line =~ /^\/\// }
	#subdomain_list.each {|sub| sub.chomp!}

	# Add a builtin domain list  
  subdomain_list = ["www", "ns1", "ns2", "ns3", "test", "mail", "owa", "vpn", "admin" ]
	@task_logger.log_good "Using subdomain list: #{subdomain_list}"

	subdomain_list.each do |sub|
		begin

			# Calculate the domain name
			domain = "#{sub}.#{@object.name}"

			# Try to resolve
			resolved_address = Resolv.new.getaddress(domain)
			@task_logger.log_good "Resolved Address #{resolved_address} for #{domain}" if resolved_address
			
			# If we resolved, create the right objects
			if resolved_address
				@task_logger.log_good "Creating domain and host objects..."			
				create_object Domain, {:name => domain, :organization => @object.organization }
				create_object Host, {:ip_address => resolved_address, :name => domain, :organization => @object.organization}
			end

		rescue Exception => e
			@task_logger.log_error "Hit exception: #{e}"
		end
	end
end
