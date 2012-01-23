#!/usr/bin/ruby
current_dir = File.expand_path(File.dirname(__FILE__))
require "#{current_dir}/../config/environment"

top_domains = File.join current_dir, "..", "data", "domain_top1k.list"
f = File.open(top_domains) 

puts "Importing #{top_domains}"
f.each { |line| 
	d = Domain.create :name => line.chomp
}
puts "Done."
