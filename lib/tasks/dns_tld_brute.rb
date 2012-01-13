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

  # Find more info here: http://www.icann.org/en/tlds/

  if options['tld_list']
    # Add a builtin domain list  
    tld_list = ['ac', 'ad', 'aeaero', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao', 'aq', 'ar',
    'arpa', 'as', 'asia', 'at', 'au', 'aw', 'ax', 'az', 'ba', 'bb', 'bd', 'be', 'bf', 'bg',
    'bh', 'bi', 'biz', 'bj', 'bm', 'bn', 'bo', 'br', 'bs', 'bt', 'bv', 'bw', 'by', 'bzca',
    'cat', 'cc', 'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'com', 'coop',
    'cr', 'cu', 'cv', 'cx', 'cy', 'cz', 'de', 'dj', 'dk', 'dm', 'do', 'dz', 'ec', 'edu', 'ee',
    'eg', 'er', 'es', 'et', 'eu', 'fi', 'fj', 'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge',
    'gf', 'gg', 'gh', 'gi', 'gl', 'gm', 'gn', 'gov', 'gp', 'gq', 'gr', 'gs', 'gt', 'gu', 'gw',
    'gy', 'hk', 'hm', 'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'im', 'in', 'info', 'int',
    'io', 'iq', 'ir', 'is', 'it', 'je', 'jm', 'jo', 'jobs', 'jp', 'ke', 'kg', 'kh', 'ki', 'km',
    'kn', 'kp', 'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk', 'lr', 'ls', 'lt', 'lu',
    'lv', 'ly', 'ma', 'mc', 'md', 'me', 'mg', 'mh', 'mil', 'mk', 'ml', 'mm', 'mn', 'mo',
    'mobi', 'mp', 'mq', 'mr', 'ms', 'mt', 'mu', 'museum', 'mv', 'mw', 'mx', 'my', 'mz', 'na',
    'name', 'nc', 'ne', 'net', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz', 'om',
    'org', 'pa', 'pe', 'pf', 'pg', 'ph', 'pk', 'pl', 'pm', 'pn', 'pr', 'pro', 'ps', 'pt', 'pw',
    'py', 'qa', 're', 'ro', 'rs', 'ru', 'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si',
    'sj', 'sk', 'sl', 'sm', 'sn', 'so', 'sr', 'st', 'su', 'sv', 'sy', 'sz', 'tc', 'td', 'tel',
    'tf', 'tg', 'th', 'tj', 'tk', 'tl', 'tm', 'tn', 'to', 'tp', 'tr', 'travel', 'tt', 'tv',
    'tw', 'tz', 'ua', 'ug', 'uk', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi', 'vn', 'vu',
    'wf', 'ws', 'ye', 'yt', 'za', 'zm', 'zw']
  else
    tld_list = options['tld_list']
  end

  generic_tld_list = ['co','com','net','biz','org']

  @task_logger.log_good "Using subdomain list: #{subdomain_list}"

  tld_list.each do |sub|
    begin

      # Calculate the domain name
      domain = "#{@object.name}.#{tld}"

      # Try to resolve
      resolved_address = Resolv.new.getaddress(domain)
      @task_logger.log_good "Resolved Address #{resolved_address} for #{domain}" if resolved_address

      # If we resolved, create the right objects
      if resolved_address
        @task_logger.log_good "Creating domain and host objects..."
        create_object(Domain, {:name => domain, :organization => @object.organization })
        create_object(Host, {:ip_address => resolved_address, :name => domain, :organization => @object.organization})
      end

    rescue Exception => e
      @task_logger.log_error "Hit exception: #{e}"
    end
  end
end
