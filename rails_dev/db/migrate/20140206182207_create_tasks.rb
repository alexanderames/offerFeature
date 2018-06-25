class CreateTasks < ActiveRecord::Migration[5.2]
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
  end
end
