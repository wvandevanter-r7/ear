class Organization < ActiveRecord::Base
	has_many :domains
	has_many :users
	has_many :hosts	
	
	validates_uniqueness_of :name
  validates_presence_of :name

	include ModelHelper

 	def to_s
	  "#{self.class}: #{self.name}"
	end

end
