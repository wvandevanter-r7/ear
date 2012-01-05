#!/usr/bin/ruby

require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

f = File.open(ARGV[0])

puts "Importing..."
f.each { |line| 
	d = Domain.create :name => line.chomp
}
puts "Done."
