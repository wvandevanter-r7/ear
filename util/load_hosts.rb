#!/usr/bin/ruby

current_dir = File.expand_path(File.dirname(__FILE__))

# make sure this file is in the root of the ear directory
require "#{current_dir}/../config/environment"

# open up a list of domains
f = File.open("#{current_dir}/../data/pca.list", "r")

puts "Running..."
f.each do |line| 
  puts "trying #{line}"
  begin 

    # create the domain object
    #h = Host.create :ip_address => line.strip

  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end

# add in a lookup
Host.all.each do |h|
    #h.run_task "geolocate_host"
    #h.run_task "dns_reverse_lookup"
    puts h
    puts "  #{h.locations}"
end

#Domain.all.each do |d|
#    d.run_task "dns_forward_lookup"
#end

puts "Done."
