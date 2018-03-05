class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :address
      t.int :contact
      t.date :dob, null: false
       
      t.timestamps
    end
  end
end
