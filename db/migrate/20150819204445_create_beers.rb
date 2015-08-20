class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name, null: false
      t.string :details
      t.string :details_html

      t.decimal :abv, null: false
      t.decimal :ibu, null: false
      t.decimal :srm
      t.decimal :fg

      t.integer :brewery_id, null: false
      t.integer :beer_style_id, null: false

      t.timestamps null: false
      t.index :brewery_id
      t.index :beer_style_id
    end
  end
end
