require 'test_helper'

class DomainTest < ActiveSupport::TestCase

	test "valid domain" do 
		Domain.create :name => "test.com"
		assert Domain.first.name == "test.com"
	end

end
