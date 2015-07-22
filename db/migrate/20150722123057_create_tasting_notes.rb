class CreateTastingNotes < ActiveRecord::Migration
  def change
    create_table :tasting_notes do |t|

      t.timestamps null: false
    end
  end
end
