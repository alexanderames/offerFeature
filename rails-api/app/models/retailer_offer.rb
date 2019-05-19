# RetailerOffer Schema
# id: ID
# retailer_id: ID
# offer_id: ID
# created_at: DateTimeType
# updated_at: DateTimeType

class RetailerOffer < ActiveRecord::Base
  belongs_to :retailer
  belongs_to :offer
end
