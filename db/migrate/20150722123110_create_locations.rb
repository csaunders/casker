class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country, null: false

      t.timestamps null: false
      t.index :city
      t.index :country
    end
  end
end
