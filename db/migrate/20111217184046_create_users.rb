class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :truthiness
      t.string :first_name
      t.string :last_name
      t.string :alias
      t.integer :organization_id
      t.text :sources
      t.text :notes
      t.timestamps
    end
  end
end
