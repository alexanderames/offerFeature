class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :offer
      t.string :task_type
      t.float :amount
      t.text :content
      t.string :url
      t.string :thumbnail_url

      t.timestamps
    end
    add_index :tasks, :offer_id
  end
end
