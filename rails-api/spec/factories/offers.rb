# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :offer do
    name { Faker::Company.unique.name }
    description { Faker::Company.catch_phrase }
    terms { Faker::Company.bs }
    image_url { Faker::Company.logo }
    expiration { Faker::Date.forward(365) }
  end
end
