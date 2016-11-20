class AddStatusToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :status, :integer, default: 0
  end
end
