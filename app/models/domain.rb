class Domain < ActiveRecord::Base
  belongs_to :organization

	include ModelHelper

  def to_s
	  "#{self.class}: #{self.name}"
	end

end
