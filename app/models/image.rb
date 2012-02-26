class Image < ActiveRecord::Base
  has_many     :task_runs
  has_many     :task_results, :through => :task_runs
  has_many     :physical_locations
  after_save   :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.remote_path}:#{self.local_path}"
  end

  def filename
    self.local_path.split(File::SEPARATOR).last
  end

private

  def log
    EarLogger.instance.log self.to_s
  end

end
