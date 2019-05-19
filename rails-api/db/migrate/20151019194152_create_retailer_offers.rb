class CreateRetailerOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :retailer_offers do |t|
      t.references :retailer
      t.references :offer

      t.timestamps
    end
  end
end
