class Offer < ActiveRecord::Base
  has_many :tasks
  has_many :retailer_offers
  has_many :retailers, through: :retailer_offers
end
