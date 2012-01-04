# This script simply requires all files in the lib directory. 
Dir[Rails.root + 'lib/ear/*.rb'].each do |file|
  require file
end

Dir[Rails.root + 'lib/client/*.rb'].each do |file|
  require file
end
