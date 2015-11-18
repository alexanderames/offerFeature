class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :store, index: true
      t.string :customer_id
      t.float :lat
      t.float :long
      t.datetime :event_at

      t.timestamps
    end
    add_index :events, :customer_id
  end
end
