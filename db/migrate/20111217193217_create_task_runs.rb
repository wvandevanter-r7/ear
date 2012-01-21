class CreateTaskRuns < ActiveRecord::Migration
  def change
    create_table :task_runs do |t|
      t.string :name
      t.integer :task_object_id
      t.string :task_object_type
      t.text :task_options_hash
      t.integer :object_mapping_id
      t.timestamps
    end
  end
end
