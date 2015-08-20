class CreateWishlistEntries < ActiveRecord::Migration
  def change
    create_table :wishlist_entries do |t|
      t.integer :beer_id, null: false
      t.integer :wishlist_id, null: false
      t.boolean :done, default: false

      t.timestamps null: false
      t.index :wishlist_id
    end
    add_foreign_key :wishlist_entries, :wishlists, on_delete: :cascade
  end
end
