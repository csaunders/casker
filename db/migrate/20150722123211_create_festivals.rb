class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name, null: false
      t.text :description
      t.text :description_html
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :website, null: false
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :address, null: false
      t.integer :location_id, null: false

      t.timestamps null: false

      t.index :location_id
      t.index :starts_at
    end
  end
end
