require 'rex'

def name
  "convert_netblock_to_hosts"
end

## Returns a string which describes what this task does
def description
  "This task converts a netblock into host records"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  return [NetBlock]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
  r = Rex::Socket::Rangewalker @object.addresses
  r.each do|address|
    create_object(Host, {:ip_address => address})
  end
end

def cleanup
  super
end
