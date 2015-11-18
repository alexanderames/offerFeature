# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    customer_id "MyString"
    zip "MyString"
    lat 1.5
    long 1.5
  end
end
