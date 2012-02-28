class WebApp < ActiveRecord::Base
  belongs_to :net_svc
  has_many    :web_forms
  has_many    :task_runs

  after_save :log
  
  include ModelHelper

  def to_s
    "#{self.class}: #{self.name} -  #{self.url}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
end
