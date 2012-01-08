class CreateSearchStrings < ActiveRecord::Migration
  def change
    create_table :search_strings do |t|
      t.integer :truthiness
      t.string :name
      t.timestamps
    end
  end
end
