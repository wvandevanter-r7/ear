def name
  "dns_reverse_lookup"
end

def description
  "Reverse DNS Lookup"
end

## Returns an array of valid types for this task
def allowed_types
  [Host]
end

def setup(object, options={})
  super(object, options)
end

def run
  super

  begin

    resolved_name = Resolv.new.getname(@object.ip_address).to_s

    if resolved_name
      @task_logger.log_good "Creating domain #{name}"
      
      # Create our new domain object with the resolved name
      d = create_object(Domain, {:name => resolved_name})

      # Assocate the resolved name with the host
      @object.domains << d # add a domain name for this host
      d.hosts << @object # add this host as an address

      # Save the raw data
      #@task_run.save_raw_result resolved_name.to_s

    else
      @task_logger.log "Unable to find a name for #{@object.ip_address}"
    end

  rescue Exception => e
    @task_logger.log_error "Hit exception: #{e}"
  end


end

def cleanup
  super
end

