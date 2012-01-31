#!/usr/bin/ruby

# make sure this file is in the root of the ear directory
require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

# open up a list of domains
f = File.open("../data/domain_top1k.list", "r")

puts "Running..."
# For each domain
f.each do |line| 
  puts "trying #{line}"
  begin 

    # create the domain object
    d = Domain.create :name => line.strip
  
    # Screenshot task. -- add more tasks here.
    #d.run_task "web_screenshot", { :timeout => "20" }
    #d.run_task "web_grab", { :timeout => "20" }
    d.run_task "dns_srv_brute"

    # Print the contents of the page (from the grab task)
    #puts d.records.first.content 

    # Or by relationship
    #puts d.children.first.content

    # basically ignore any problems, just print'm - EAR should handle most exceptions.
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
puts "Done."
