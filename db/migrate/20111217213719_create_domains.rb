class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :truthiness
      t.string :name
      t.string :status
      t.integer :organization_id
      t.text :sources
      t.timestamps
    end
  end
end
