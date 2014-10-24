class CreateCasks < ActiveRecord::Migration
  def change
    create_table :casks do |t|
      t.integer :cask, null: false, unique: true
      t.string :region, null: false
      t.string :brewery, null: false
      t.string :name, null: false
      t.string :style, null: false
      t.decimal :abv, precision: 5, scale: 2, null: false
      t.integer :session, default: 0

      t.timestamps
    end

    add_index(:casks, :cask)
    add_index(:casks, :region)
    add_index(:casks, :style)
    add_index(:casks, :session)
  end
end
