module Types
  class RetailerOfferType < Types::BaseObject

    field :id, ID, null: false
    field :retailer_id, ID, null: false
    field :offer_id, ID, null: false
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false

  end
end
