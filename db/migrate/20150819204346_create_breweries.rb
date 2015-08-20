class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :name, null: false
      t.string :tagline
      t.string :website, null: false
      t.integer :location_id, null: false

      t.timestamps null: false
      t.index :location_id
    end
  end
end
