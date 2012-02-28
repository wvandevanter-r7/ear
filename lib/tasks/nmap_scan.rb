def name
  "nmap_scan"
end

## Returns a string which describes what this task does
def description
  "This task runs an nmap scan on the target host or domain."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  return [Domain, Host, NetBlock]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
  
  nmap_options = @options['nmap_options']
  
  if @object.kind_of? Host
    to_scan = @object.ip_address
  elsif @object.kind_of? NetBlock
    to_scan = @object.range
  elsif @object.kind_of? Domain
    to_scan = @object.name
  else
    raise ArgumentError, "Unknown object type"
  end
  
  rand_file_path = "#{Dir::tmpdir}/nmap_scan_#{to_scan}_#{rand(100000000)}.xml"
  
  # shell out to nmap and run the scan
  @task_logger.log "scanning #{to_scan} and storing in #{rand_file_path}"
  @task_logger.log "nmap options: #{nmap_options}"
  
  safe_system("nmap #{to_scan} #{nmap_options} -oX #{rand_file_path}")
  
  # Gather the XML and parse
  @task_logger.log "Parsing #{rand_file_path}"
  parser = Nmap::Parser.parsefile(rand_file_path)

  # Create objects for each discovered service
  parser.hosts("up") do |host|

    @task_logger.log "Handling nmap data for #{host.addr}"

    # Handle the case of a netblock or domain - where we will need to create host object(s)
    master_object = @object
    if @object.kind_of? NetBlock or @object.kind_of? Domain
      @object = create_object(Host, {:ip_address => host.addr })
    end

    [:tcp, :udp].each do |proto_type|
      host.getports(proto_type, "open") do |port|
      @task_logger.log "Creating Service: #{port}"
      create_object(NetSvc, {
        :host_id => @object.id,
        :port_num => port.num,
        :proto => port.proto,
        :fingerprint => "#{port.service.name} #{port.service.product} #{port.service.version}"})
      end
      # reset this back to the main task object & loop
      @object = master_object
    end
  
  end
end

def cleanup
  super
end
