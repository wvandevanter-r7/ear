def name
  "example"
end

## Returns a string which describes what this task does
def description
  "This is an example EAR task. It associates a random host with the calling object."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  return [Domain, Host, Organization, SearchString, User]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
  ip = "#{rand(100)}.#{rand(100)}.#{rand(100)}.#{rand(100)}"
  x = create_object Device, { :ip_address => ip }
end

def cleanup
  super
end
