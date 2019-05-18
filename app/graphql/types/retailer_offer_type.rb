module Types
  class RetailerOfferType < Types::BaseObject

    field :id, ID, null: false
    field :retailer_id, ID, null: false
    field :offer_id, ID, null: false
    field :created_at, DateTime, null: false
    field :updated_at, DateTime, null: false

  end
end
