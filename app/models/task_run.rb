class TaskRun < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :physical_address
  belongs_to :domain
  belongs_to :host
  belongs_to :net_svc
  belongs_to :web_app
  belongs_to :web_form
  has_many :task_results

  def to_s
    "#{name} task ran on #{task_object_type}:#{task_object_id} with options #{task_options_hash} - generated #{task_results.count} results"
  end

  def save_raw_result(content, type="String")
    self.task_results << TaskResult.create(:name => name, :content => content, :type => type)
  end
end
