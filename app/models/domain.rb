class Domain < ActiveRecord::Base
  belongs_to :organization
  has_many   :hosts
  has_many   :task_runs
  has_many    :task_results, :through => :task_runs
  
  validates_uniqueness_of :name
  validates_presence_of   :name

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
