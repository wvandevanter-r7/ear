class Host < ActiveRecord::Base
  belongs_to :organization

	serialize :sources

	validates_uniqueness_of :ip_address
  validates_presence_of :ip_address

	include ModelHelper

  def to_s
	  "#{self.class}: #{self.ip_address}"
	end

end
