class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :name
      t.text :description
      t.text :terms
      t.string :image_url
      t.datetime :expiration

      t.timestamps
    end
  end
end
