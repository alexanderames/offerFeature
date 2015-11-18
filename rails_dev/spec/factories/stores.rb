# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :store do
    retailer nil
    address "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    lat 1.5
    long 1.5
  end
end
