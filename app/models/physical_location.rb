class PhysicalLocation < ActiveRecord::Base
  after_save :log

private
  def log
    EarLogger.instance.log self.to_s
  end

end
