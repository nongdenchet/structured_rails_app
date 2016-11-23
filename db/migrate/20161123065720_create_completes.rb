class CreateCompletes < ActiveRecord::Migration[5.0]
  def change
    create_table :completes do |t|
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
