class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :ip_address
      t.integer :organization_id
      t.text :notes
      t.timestamps
    end
  end
end
