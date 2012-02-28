# This script simply requires all files in the lib directory. 
Dir[Rails.root + 'lib/ear/*.rb'].each do |file|
  require file
end

# Require all clients
Dir[Rails.root + 'lib/client/*.rb'].each do |file|
  require file
end

# Intialize the API database
require Rails.root + 'lib/ear/ear_api_keys.rb'


# Task Manager Setup
TaskManager.instance.load_tasks

# Object Manager Setup
