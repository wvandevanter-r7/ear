def name
  "whois"
end

## Returns a string which describes what this task does
def description
  "Whois lookup"
end

## Returns an array of valid types for this task
def allowed_types
  [Host, Domain]
end

def setup(object, options={})
  super(object, options)
end

def run
  super

  begin 
    answer = Whois::Client.new.query(@object.name)
  rescue Exception => e
    @task_logger.log "Unable to query whois: #{e}"
  end


  if answer
    # TODO - parse this badboy up

    answer.nameservers.each do |nameserver|
      create_object Domain, :name => nameserver.to_s
    end

    # Contact
    #answer.technical


    # Save the raw data
    @task_run.result_content = answer.to_s

  else
    @task_logger.log "Domain WHOIS failed, we don't know what nameserver to query."
  end

end

def cleanup
  super
end
