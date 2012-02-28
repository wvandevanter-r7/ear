class PhysicalLocation < ActiveRecord::Base
  belongs_to    :organization
  has_many      :task_runs

  after_save    :log

  include ModelHelper
  
  def to_s
    "#{self.class}: #{address} #{city} #{state} #{country} (#{latitude} #{longitude})"
  end
  

private
  def log
    EarLogger.instance.log self.to_s
  end

end
