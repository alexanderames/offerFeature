class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :zip
      t.float :lat
      t.float :long

      t.timestamps
    end
    add_index :customers, :customer_id, unique: true
  end
end
