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
  # create an ip
  ip_address = "#{rand(255)}.#{rand(255)}.#{rand(255)}.#{rand(255)}"
  x = create_object Host, { :ip_address => ip_address }
  # Keep track of our raw data
  @task_run.result_content = ip_address
end

def cleanup
  super
end
