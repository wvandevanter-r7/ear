class TaskRun < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :physical_address
  belongs_to :domain
  belongs_to :host
  belongs_to :net_svc
  belongs_to :web_app
  belongs_to :web_form

  def to_s
    "#{name} task -> #{task_object_type}:#{task_object_id} with options #{task_options_hash}"
  end
end
