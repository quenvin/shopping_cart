class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
