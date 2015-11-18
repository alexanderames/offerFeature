class Event < ActiveRecord::Base
  belongs_to :store
  belongs_to :customer, foreign_key: :customer_id, primary_key: :customer_id
end
