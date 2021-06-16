class CreateTrucks < ActiveRecord::Migration[6.1]
  def change
    create_table :trucks do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :zipcode
      t.boolean :online, default: true
    end
  end
end
