class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.date :date, null: false

      t.timestamps
    end

    add_index :entries, [:user_id, :date], unique: true
  end
end
