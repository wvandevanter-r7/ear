def name
  "google_hostnames"
end

## Returns a string which describes what this task does
def description
  "This looks up a keyword on google, and adds the discovered hostname to the database."
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

end

def cleanup
  super
end
