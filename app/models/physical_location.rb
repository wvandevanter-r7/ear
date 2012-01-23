class PhysicalLocation < ActiveRecord::Base
  belongs_to    :organization
  has_many      :task_runs
  has_many      :task_results, :through => :task_runs

  after_save    :log

  include ModelHelper
  
  def to_s
    "#{self.class}: #{address} #{city} #{state} #{country}"
  end
  

private
  def log
    EarLogger.instance.log self.to_s
  end

end
