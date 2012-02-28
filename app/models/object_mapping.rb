class ObjectMapping < ActiveRecord::Base
#    has_one :task_run

    def get_child
      EarLogger.instance.log "Trying to find #{child_type}:#{child_id}"
      
      begin
        eval "#{child_type}.find #{child_id}"
      rescue ActiveRecord::RecordNotFound => e
        EarLogger.instance.log "Oops, couldn't find #{child_type}:#{child_id}"
        nil
      end
      
    end
    
    def get_parent
      EarLogger.instance.log "Trying to find #{parent_type}:#{parent_id}"
      
      begin
        eval "#{parent_type}.find #{parent_id}"
      rescue ActiveRecord::RecordNotFound => e
        EarLogger.instance.log "Oops, couldn't find #{child_type}:#{child_id}"
        nil
      end
    
    end

    def get_task_run
      TaskRun.find self.task_run_id
    end

    def to_s
      "#{self.class}: #{child_type}:#{child_id} <-> #{parent_type}:#{parent_id}"
    end 

end
