class Finding < ActiveRecord::Base
  has_many     :task_runs
  
  after_save   :log

  include ModelHelper

  def to_s
    "#{self.class}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
end
