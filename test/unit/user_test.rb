require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "valid user" do 
		User.create :first_name => "jesus", :last_name => "christ"
		assert SearchString.first_name == jesus
	end
end
