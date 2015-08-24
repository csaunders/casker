class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :name, null: false
      t.string :processor, null: false
      t.text :raw_data, null: false
      t.text :processed_data
      t.timestamps null: false
    end

    change_table :festivals do |t|
      t.boolean :published, default: false, null: false
    end
  end
end
