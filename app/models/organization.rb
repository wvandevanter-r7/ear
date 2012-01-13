class Organization < ActiveRecord::Base
  has_many :domains
  has_many :users
  has_many :hosts  
  has_many :records
  has_many :physical_locations
  
  serialize :sources

  validates_uniqueness_of :name
  validates_presence_of :name

  include ModelHelper

   def to_s
    "#{self.class}: #{self.name}"
  end

end
