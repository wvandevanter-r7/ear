def name
  "web_grab"
end

## Returns a string which describes what this task does
def description
  "This task grabs the www record and adds a record with the contents"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [Domain, Host]
end

def setup(object, options={})
  super(object, options)

  if @object.kind_of? Host
    url = "http://#{@object.ip_address}"
  else
    url = "http://www.#{@object.name}"
  end

    @task_logger.log "Connecting to #{url} for #{@object}" 

    begin

      status = Timeout.timeout 10 do
        # Prevent encoding errors
        contents = open("#{url}").read.force_encoding('UTF-8')
        @task_run.save_raw_result contents
      end

    rescue Timeout::Error
      @task_logger.log "Timeout!"
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
    rescue ArgumentError => e
      @task_logger.log "Argument Error #{e}"
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
