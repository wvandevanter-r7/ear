require 'test_helper'

class HostTest < ActiveSupport::TestCase
	test "valid host" do 
		host.create :ip_address => "8.8.8.8"
		assert Host.first.name == "8.8.8.8"
	end
end
