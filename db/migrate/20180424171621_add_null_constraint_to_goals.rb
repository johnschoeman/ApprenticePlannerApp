class AddNullConstraintToGoals < ActiveRecord::Migration[5.1]
  def change
    change_column :goals, :description, :string, null: false, default: "", limit: 255
  end
end
