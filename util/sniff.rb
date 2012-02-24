#!/usr/bin/env ruby

puts "Loading Rails environment"

require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"
require "packetfu"

@excluded = [ "^172.16", "^192.168" , "^74.16", "^74.125", "^224.0.0", "^199.71", "^199.43", "^199.212"]
@included = [ "^10.0.0" ]

raise ArgumentError, "Please specify interface" unless ARGV[0]

@cap = PacketFu::Capture.new(:iface => ARGV[0],
  :start => true,
  :filter => "ip")

@cap.stream.each do |pkt| 

  #  begin
  packet = PacketFu::Packet.parse(pkt)

  # Check to see if it's in our exclusion list
  excluded = false

  @excluded.each do |excluded_regex|
      if Regexp.new(excluded_regex).match(packet.ip_daddr.to_s)
        excluded = true
        break
      end
  end

  next unless !excluded || !packet.is_ip?
  
  #Check to see if we have the host's details already
  host = Host.find_by_ip_address(packet.ip_daddr)
  next if host

  puts "New host: #{packet.ip_daddr}, creating a record..."
  h = Host.new(:ip_address => packet.ip_daddr)
end
