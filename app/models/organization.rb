class Organization < ActiveRecord::Base
  has_many :domains
  has_many :users
  has_many :physical_locations
  has_many :hosts, :through => :domains
  has_many :net_svcs, :through => :hosts
  has_many :web_apps, :through => :net_svcs
  has_many :web_forms, :through => :web_apps

  validates_uniqueness_of :name
  validates_presence_of :name

  after_save :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end

end
