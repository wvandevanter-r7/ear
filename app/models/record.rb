class Record < ActiveRecord::Base
  after_save :log

  serialize :content

  include ModelHelper

  def to_s
    "#{self.class}: #{name} (#{object_type})"
  end

private
  def log
    EarLogger.instance.log "#{self.to_s}\n#{self.content}\n"
  end
end
