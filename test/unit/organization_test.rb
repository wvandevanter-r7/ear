require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
	test "valid organization" do 
		Organization.create :name => "ACME Corp"
		assert SearchString.first_name == "ACME Corp"
	end
end
