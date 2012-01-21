class Host < ActiveRecord::Base
  belongs_to :organization
  has_many :records

  after_save :log

  validates_uniqueness_of :ip_address
  validates_presence_of :ip_address

  include ModelHelper

  def to_s
    "#{self.class}: #{self.ip_address}"
  end

private

  def log
    EarLogger.instance.log self.to_s
  end

end
