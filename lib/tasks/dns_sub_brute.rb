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

    # :subdomain_list => list of subdomains to brute
    # :mashed_domains => try domain names w/o a dot, see if anyone's hijacked a common "subdomain"


  if @options[:subdomain_list]
    subdomain_list = @options['subdomain_list']
  else
    # Add a builtin domain list  
    subdomain_list = ["www", "ww2", "ns1", "ns2", "ns3", "test", "mail", "owa", "vpn", "admin",
      "gateway", "secure", "admin", "service", "tools", "doc", "docs", "network", "help", "en" ]
  end

  @task_logger.log_good "Using subdomain list: #{subdomain_list}"

  result_list = []

  subdomain_list.each do |sub|
    begin

      # Calculate the domain name
      if @options[:mashed_domains]
      
        # blatently stolen from HDM's webinar on password stealing, try without a dot to see
        # if this domain has been hijacked by someone - great for finding phishing attempts
        domain = "#{sub}#{@object.name}"
      else  
        domain = "#{sub}.#{@object.name}"
      end

      # Try to resolve
      resolved_address = Resolv.new.getaddress(domain)
      @task_logger.log_good "Resolved Address #{resolved_address} for #{domain}" if resolved_address
      
      # If we resolved, create the right objects
      if resolved_address
        @task_logger.log_good "Creating domain and host objects..."      
        create_object(Domain, {:name => domain, :organization => @object.organization })
        create_object(Host, {:ip_address => resolved_address, :name => domain, :organization => @object.organization})
      end

      result_list << "#{domain}: #{resolved_address}"

    rescue Exception => e
      @task_logger.log_error "Hit exception: #{e}"
    end
  end
  
  # Keep track of our raw data
  @task_run.result_content= resolved_addresses.to_s
  
end
