class TaskRun < ActiveRecord::Base
	belongs_to :object_mapping	

  def to_s
    "Task ran on #{task_object_type}:#{task_object_id} with options #{task_options_hash}"
  end

end
