class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :description, limit: 255
      t.integer :entry_id, null: false

      t.timestamps
    end

    add_index :goals, :entry_id
  end
end
