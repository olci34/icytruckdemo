class CreateIcecreams < ActiveRecord::Migration[6.1]
  def change
    create_table :icecreams do |t|
      t.string :name
      t.float :price
      t.integer :truck_id
    end
  end
end
