# Offer Schema
# id: ID
# name: STRING
# description: STRING
# terms: STRING
# image_url: URL
# expiration: DateTimeType
# created_at: DateTimeType
# updated_at: DateTimeType

class Offer < ActiveRecord::Base
  has_many :retailer_offers
  has_many :retailers, through: :retailer_offers
end
