class CreateIcecreamsOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :icecreams_orders do |t|
      t.integer :order_id
      t.integer :icecream_id
      t.integer :quantity
      t.float :total, default: 0.0
    end
  end
end
