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
  
  begin
    if @object.kind_of? Host
      @task_logger.log "Connecting to http://www.#{@object.name}" 
      contents = open("http://#{@object.ip_address}")
    else #Domain
      @task_logger.log "Connecting to http://www.#{@object.name}" 
      contents = open("http://www.#{@object.name}")
    end
  rescue SocketError => e
   @task_logger.log "Unable to connect" 
   return 
  end

  @object.records << create_object(Record, {
    :name => "robots_txt", 
    :object_type => "String", 
    :content => contents.read}
  )

end

## Default method, subclasses must override this
def run
  super
end

def cleanup
  super
end
