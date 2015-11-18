class Store < ActiveRecord::Base
  belongs_to :retailer
  has_many :events
end
