class SearchString < ActiveRecord::Base

	include ModelHelper

  def to_s
	  "#{self.class}: #{self.name}"
	end

end
