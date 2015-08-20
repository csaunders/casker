class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :name, null: false
      t.string :user_id, null: false
      t.integer :festival_id, null: false

      t.timestamps null: false
      t.index :user_id
    end
  end
end
