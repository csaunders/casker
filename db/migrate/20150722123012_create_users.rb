class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :identifier, unique: true
      t.string :authenticated_by, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
      t.index :authenticated_by
      t.index :identifier
    end
  end
end
