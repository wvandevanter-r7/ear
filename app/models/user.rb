class User < ActiveRecord::Base
  belongs_to :organization
  has_many :records

  after_save :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.last_name}, #{self.first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
  
end
