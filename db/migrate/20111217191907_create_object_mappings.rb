class CreateObjectMappings < ActiveRecord::Migration
  def change
    create_table :object_mappings do |t|
      t.integer :child_id
      t.string :child_type
      t.integer :parent_id
      t.string :parent_type
			t.integer :organization_id
			t.integer :domain_id
			t.integer :user_id
			t.integer :host_id
			t.integer :task_run_id
      t.timestamps
    end
  end
end
