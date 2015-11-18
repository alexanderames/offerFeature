class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.references :retailer, index: true
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
