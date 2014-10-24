class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.integer :attendee_id
      t.integer :cask_id
      t.boolean :done
      t.boolean :favourite

      t.timestamps
    end

    add_index(:drinks, [:attendee_id, :done])
    add_index(:drinks, [:attendee_id, :favourite])
  end
end
