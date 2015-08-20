class CreateBeerStyles < ActiveRecord::Migration
  def change
    create_table :beer_styles do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
