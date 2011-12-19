require 'test_helper'

class SearchStringTest < ActiveSupport::TestCase
	test "valid search string" do 
		SearchString.create :name => "test"
		assert SearchString.first.name == "test"
	end
end
