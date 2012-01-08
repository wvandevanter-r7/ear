class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :name
      t.string :object_type
      t.text :content
      t.integer :organization_id
      t.integer :domain_id
      t.integer :host_id
      t.integer :user_id
      t.timestamps
    end
  end
end
