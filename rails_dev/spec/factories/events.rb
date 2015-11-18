# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    store nil
    customer_id "MyString"
    lat 1.5
    long 1.5
    event_at "2014-05-21 16:44:17"
  end
end
