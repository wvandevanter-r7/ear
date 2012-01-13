class Record < ActiveRecord::Base
  serialize :content
  
  def to_s
    "#{self.class}: #{name} (#{object_type})"
  end

end
