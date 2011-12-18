class User < ActiveRecord::Base
	belongs_to :organization

	include ModelHelper

	def to_s
	  "#{self.class}: #{self.last_name}, #{self.first_name}"
	end

	def full_name
		"#{first_name} #{last_name}"
	end

end
