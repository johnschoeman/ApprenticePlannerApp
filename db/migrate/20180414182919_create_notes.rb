class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :content, null: false
      t.integer :entry_id, null: false

      t.timestamps
    end

    add_index :notes, :entry_id, unique: true
    add_foreign_key :notes, :entries
  end
end
