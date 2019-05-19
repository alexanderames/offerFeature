# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :retailer do
    name { Faker::Company.unique.name }
    created_at { Faker::Date.backward(365) }
  end
end
