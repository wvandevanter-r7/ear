class TaskRun < ActiveRecord::Base
  before_save :default_values
  belongs_to :object_mapping  

  def to_s
    "Task ran on #{task_object_type}:#{task_object_id} with options #{task_options_hash}"
  end

  def default_values
    self.result_type = "String" unless self.result_type
  end

  def save_raw_content(content)
    self.result_content = content
    self.save!
  end
end
