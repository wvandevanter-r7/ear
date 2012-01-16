def name
  "robots_txt"
end

## Returns a string which describes what this task does
def description
  "This task grabs the robots.txt and adds a record with the contents"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [Domain, Host]
end

def setup(object, options={})
  super(object, options)

  if @object.kind_of? Host
    url = "http://#{@object.ip_address}/robots.txt"
  else
    url = "http://www.#{@object.name}/robots.txt"
  end
  
  begin
    @task_logger.log "Connecting to #{url} for #{@object}" 

    # Prevent encoding errors
    # Encoding::UndefinedConversionError: "\xEF" from ASCII-8BIT to UTF-8
    #ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    contents = open("#{url}").read.encode Encoding::ISO_8859_1, :undef => :replace

    # Create a record and save the content of the robot.txt file
    @object.records << create_object(Record, {
      :name => "robots_txt", 
      :object_type => "String", 
      :content => contents}
    )
  rescue OpenURI::HTTPError => e
    @task_logger.log "Unable to connect: #{e}"
  rescue Net::HTTPBadResponse => e
    @task_logger.log "Unable to connect: #{e}"
  rescue EOFError => e
    @task_logger.log "Unable to connect: #{e}"
  rescue SocketError => e
    @task_logger.log "Unable to connect: #{e}"
  rescue RuntimeError => e
    @task_logger.log "Unable to connect: #{e}"
  rescue SystemCallError => e
    @task_logger.log "Unable to connect: #{e}"
  rescue Encoding::InvalidByteSequenceError => e
    @task_logger.log "Encoding error: #{e}"
  rescue Encoding::UndefinedConversionError => e
    @task_logger.log "Encoding error: #{e}"
  end


end

## Default method, subclasses must override this
def run
  super
end

def cleanup
  super
end
