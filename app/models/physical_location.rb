class PhysicalLocation < ActiveRecord::Base
  belongs_to :organization
  after_save :log

  include ModelHelper

private
  def log
    EarLogger.instance.log self.to_s
  end

end
