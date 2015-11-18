class Retailer < ActiveRecord::Base
  has_many :retailer_offers
  has_many :offers, through: :retailer_offers
end
