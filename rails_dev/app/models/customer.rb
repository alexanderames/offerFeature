class Customer < ActiveRecord::Base
  has_many :events, foreign_key: :customer_id, primary_key: :customer_id
end
