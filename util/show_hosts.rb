#!/usr/bin/ruby

current_dir = File.expand_path(File.dirname(__FILE__))

# make sure this file is in the root of the ear directory
require "#{current_dir}/../config/environment"

# add in a lookup
Host.all.each do |h|
    #h.run_task "geolocate_host"
    #h.run_task "dns_reverse_lookup"
    puts h
    puts "  #{h.task_runs}"
    puts "  #{TaskRun.find_by_parent_id(h.id)}"
end

#Domain.all.each do |d|
#    d.run_task "dns_forward_lookup"
#end

puts "Done."
