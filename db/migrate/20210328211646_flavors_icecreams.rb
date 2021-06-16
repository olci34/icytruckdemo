class FlavorsIcecreams < ActiveRecord::Migration[6.1]
  def change
    create_table :flavors_icecreams do |t|
      t.belongs_to :icecream
      t.belongs_to :flavor
    end
  end
end
