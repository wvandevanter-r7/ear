class ObjectMapping < ActiveRecord::Base
    has_one :task_run

    def get_child
      EarLogger.instance.log "Trying to find #{child_type}:#{child_id}"
      eval "#{child_type}.find #{child_id}"
    end
    
    def get_parent
      EarLogger.instance.log "Trying to find #{parent_type}:#{parent_id}"
      eval "#{parent_type}.find #{parent_id}"
    end

    def to_s
      "#{self.class}: #{child_type}:#{child_id} <-> #{parent_type}:#{parent_id}"
    end 

end
