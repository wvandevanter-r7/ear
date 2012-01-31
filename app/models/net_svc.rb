class NetSvc < ActiveRecord::Base
  belongs_to  :host
  has_many    :web_apps
  has_many    :task_runs
  has_many    :task_results, :through => :task_runs
  
  after_save   :log

  include ModelHelper

  def to_s
    "#{self.class}: #{proto}/#{port_num} #{fingerprint}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end

end
