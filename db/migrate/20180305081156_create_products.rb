class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :filepicker_url, default: ''
      t.decimal :price, null: false, precision: 10, scale: 2
      t.timestamps
    end
  end
end
