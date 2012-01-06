class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :truthiness
      t.string :name
      t.text :content
      t.integer :organization_id
      t.integer :domain_id
      t.integer :host_id
      t.integer :user_id
      t.timestamps
    end
  end
end
