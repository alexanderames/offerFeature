# Retailer Schema
# id: ID
# name: STRING
# created_at: DATETIME
# updated_at: DATETIME

class Retailer < ActiveRecord::Base
  has_many :retailer_offers
  has_many :offers, through: :retailer_offers
end
