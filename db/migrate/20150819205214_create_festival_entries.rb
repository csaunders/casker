class CreateFestivalEntries < ActiveRecord::Migration
  def change
    create_table :festival_entries do |t|
      t.integer :festival_id, null: false
      t.integer :beer_id, null: false
      t.integer :festival_identifier, null: false
      t.text :metadata

      t.timestamps null: false
      t.index :festival_id
    end
    add_foreign_key :festival_entries, :festivals, on_delete: :cascade
  end
end
