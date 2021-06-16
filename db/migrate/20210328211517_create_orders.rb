class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :total, default: 0.0
      t.boolean :confirmed, default: false
      t.boolean :delivered, default: false
      t.integer :truck_id
      t.integer :customer_id
      t.timestamps
    end
  end
end
