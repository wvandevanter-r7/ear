class SearchString < ActiveRecord::Base

  include ModelHelper

  after_save :log

  def to_s
    "#{self.class}: #{self.name}"
  end

private
  def log
    EarLogger.instance.log self.to_s
  end

end
