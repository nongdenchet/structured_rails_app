class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :prepare_time
      t.integer :cook_time
      t.integer :ready_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
