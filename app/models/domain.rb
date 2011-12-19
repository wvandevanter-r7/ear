class Domain < ActiveRecord::Base
  belongs_to :organization

	serialize :sources

	include ModelHelper

  def to_s
	  "#{self.class}: #{self.name}"
	end

end
