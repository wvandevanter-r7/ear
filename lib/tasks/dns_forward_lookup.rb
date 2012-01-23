def name
  "dns_forward_lookup"
end

## Returns a string which describes what this task does
def description
  "Forward DNS Lookup"
end

## Returns an array of valid types for this task
def allowed_types
  [Domain]
end

def setup(object, options={})
  super(object, options)
end

def run
  super

    begin
      resolved_address = Resolv.new.getaddress(@object.name)
      
      if resolved_address
        @task_logger.log_good "Creating host object for #{resolved_address}"
        h = create_object(Host, {:ip_address => resolved_address, :name => @object.name})
        
        @object.hosts << h
        h.domains << @object
        
        # save the raw data
        @task_run.save_raw_result resolved_address

      else
        @task_logger.log "Unable to find address for #{@object.name}"
      end

    rescue Exception => e
      @task_logger.log_error "Hit exception: #{e}"
    end

end

def cleanup
  super
end
