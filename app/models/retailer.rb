# Retailer Schema
# id: ID
# name: STRING
# created_at: DateTimeType
# updated_at: DateTimeType

class Retailer < ActiveRecord::Base
  has_many :retailer_offers
  has_many :offers, through: :retailer_offers
end
