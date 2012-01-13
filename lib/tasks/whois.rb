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
    resolved_list = nil
  rescue Exception => e
    @task_logger.log "Unable to query whois: #{e}"
  end

  # TODO - parse this badboy up

  if answer
    @object.records << create_object(Record, {:name => "whois", :object_type => answer.class.to_s, :content => answer})
  else
    @task_logger.log "Domain WHOIS failed, we don't know what nameserver to query."
  end

end

def cleanup
  super
end
