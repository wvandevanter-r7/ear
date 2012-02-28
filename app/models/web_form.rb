class WebForm < ActiveRecord::Base
  belongs_to :web_app
  has_many    :task_runs

  after_save :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.name} - #{self.url} -> #{self.action}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
end
