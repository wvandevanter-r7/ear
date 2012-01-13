class Domain < ActiveRecord::Base
  belongs_to :organization
  has_many :records
  
  serialize :sources

  include ModelHelper

  def to_s
    "#{self.class}: #{self.name}"
  end

end
