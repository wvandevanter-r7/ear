class User < ActiveRecord::Base
  belongs_to  :organization
  has_many    :task_runs
  has_many    :task_results, :through => :task_runs
  
  after_save :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.last_name}, #{self.first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end
  
end
