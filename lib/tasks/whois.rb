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
      if nameserver.to_s =~ /\d\.\d\.\d\.\d/
        create_object Host , :ip_address => nameserver.to_s
      else
        create_object Domain, :name => nameserver.to_s
      end
    end

    # if this was a host, then we should try to parse out the netrange

    # Parse out the netrange
    #create_object NetBlock, {:range => answer.parser }

    # if it was a domain, we've got a whole lot of other shit to worry about 
    # Create a user from the technical contact
    begin
      if answer.technical
        # split up the username if we can
        # TODO OMG this is horrible.
        begin
          @task_logger.log "Creating user from technical contact"
          fname,lname = answer.technical.name.split(" ")
          create_object(User, {:first_name => fname, :last_name => lname})
        rescue Exception => e
          fname = answer.technical.name
          create_object(User, {:first_name => fname })
        end
      end
    rescue Exception => e 
      @task_logger.log "Unable to grab technical contact" 
   end

    # Parse up the contacts
    answer.parser.contacts.each do |contact|
      @task_logger.log "TODO - found contact #{contact}"

        begin
          @task_logger.log "Creating user from technical contact"
          fname,lname = contact.split(" ")
          create_object(User, {:first_name => fname, :last_name => lname})
        rescue Exception => e
          fname = contact
          create_object(User, {:first_name => fname })
        end


    end

  else
    @task_logger.log "Domain WHOIS failed, we don't know what nameserver to query."
  end

end

def cleanup
  super
end
