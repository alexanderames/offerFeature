module Types
  class RetailerType < Types::BaseObject

    field :id, ID, null: false
    field :name, String, null: true
    field :created_at, DateTime, null: false
    field :updated_at, DateTime, null: false

  end
end
