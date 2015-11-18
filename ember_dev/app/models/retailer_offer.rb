class RetailerOffer < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :offer
end
