class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.text :sources
      t.timestamps
    end
  end
end
