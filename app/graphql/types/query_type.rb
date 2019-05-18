module Types
  class QueryType < Types::BaseObject

    # Offer/s.
    field :offers, [Types::OfferType], null: false

    def offers
      Offer.all
    end

    field :offer, Types::OfferType, null: false do
      argument :id, ID, required: true
    end

    def offer(id:)
      Offer.find(id)
    end

    # RetailerOffer/s.
    field :retailer_offers, [Types::RetailerOfferType], null: false

    def retailer_offers
      RetailerOffer.all
    end

    field :retailer_offer, Types::RetailerOfferType, null: false do
      argument :id, ID, required: true
    end

    def retailer_offer(id:)
      Retailer.find(id)
    end

    # Retailer.
    field :retailers, [Types::RetailerType], null: false

    def retailers
      Offer.all
    end
  end
end
