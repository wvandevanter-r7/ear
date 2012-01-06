class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.integer :truthiness
      t.string :name
      t.string :ip_address
      t.integer :organization_id
      t.text :sources
      t.text :notes
      t.timestamps
    end
  end
end
