module Types
  class RetailerType < Types::BaseObject

    field :id, ID, null: false
    field :name, String, null: true
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false

  end
end
