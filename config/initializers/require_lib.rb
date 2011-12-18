# This script simply requires all files in the lib/ear directory. 
Dir[Rails.root + 'lib/ear/*.rb'].each do |file|
  require file
end
