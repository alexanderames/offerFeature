module Types
  class OfferType < Types::BaseObject

    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :terms, String, null: true
    field :image_url, String, null: true
    field :expiration, DATETIME
    field :created_at, DateTime, null: false
    field :updated_at, DateTime, null: false

  end
end
