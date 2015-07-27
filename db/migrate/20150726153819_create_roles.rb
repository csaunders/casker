class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id, null: false
      t.string :name, null: false

      t.timestamps null: false
      t.index [:user_id, :name], unique: true
    end
    add_foreign_key :roles, :users, on_delete: :cascade
  end
end
