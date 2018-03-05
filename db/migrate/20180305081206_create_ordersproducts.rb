class CreateOrdersproducts < ActiveRecord::Migration[5.1]
  def change
    create_table :ordersproducts do |t|

      t.timestamps
    end
  end
end
