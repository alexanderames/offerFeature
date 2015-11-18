# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    offer
    task_type ""
    amount 1.5
    content "MyText"
    url "MyString"
    thumbnail_url "MyString"
  end
end
