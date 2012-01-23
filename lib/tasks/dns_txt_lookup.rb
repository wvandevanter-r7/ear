require 'dnsruby'

def name
  "dns_txt_lookup"
end

## Returns a string which describes what this task does
def description
  "DNS TXT Record Lookup"
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

  @task_logger.log "Running TXT lookup on #{@object}"

  begin
    res = Dnsruby::Resolver.new(
      :recurse => true, 
      :query_timeout => 5)

    res_answer = res.query(@object.name, Dnsruby::Types.TXT)

    # If we got a success to the query.
    if res_answer
      @task_logger.log_good "TXT lookup succeeded on #{@object.name}:\n #{res_answer.answer}"

      # TODO - Parse for netbocks and hostnames

    end

    @task_run.save_raw_result res_answer.to_s

  rescue Dnsruby::Refused
    @task_logger.log "Zone Transfer against #{@object.name} refused."

  rescue Dnsruby::ResolvError
    @task_logger.log "Unable to resolve #{@object.name}"

  rescue Dnsruby::ResolvTimeout
    @task_logger.log "Timed out while querying #{@object.name}."

  rescue Exception => e
    @task_logger.log "Unknown exception: #{e}"

  end

end

def cleanup
  super
end
