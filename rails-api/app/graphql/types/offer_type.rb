module Types
  class OfferType < Types::BaseObject

    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :terms, String, null: true
    field :image_url, String, null: true
    field :expiration, DateTimeType, null: true
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false

  end
end
