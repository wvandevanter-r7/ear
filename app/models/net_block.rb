class NetBlock < ActiveRecord::Base
  after_save   :log

  include ModelHelper

  def to_s
    "#{self.class}: #{self.range}"
  end

private

  def log
    EarLogger.instance.log self.to_s
  end
  
end
