# Offer Schema
# id: ID
# name: STRING
# description: STRING
# terms: STRING
# image_url: URL
# expiration: DATETIME
# created_at: DATETIME
# updated_at: DATETIME

class Offer < ActiveRecord::Base
  has_many :retailer_offers
  has_many :retailers, through: :retailer_offers
end
