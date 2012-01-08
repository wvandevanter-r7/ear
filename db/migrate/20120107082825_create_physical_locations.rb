class CreatePhysicalLocations < ActiveRecord::Migration
  def change
    create_table :physical_locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.integer :organization_id
      t.timestamps
    end
  end
end
