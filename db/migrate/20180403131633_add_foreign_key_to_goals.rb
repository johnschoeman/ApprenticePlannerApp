class AddForeignKeyToGoals < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :goals, :entries
  end
end
