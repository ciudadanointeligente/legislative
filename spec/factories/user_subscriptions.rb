# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_subscription do
    user_email 1
    bill "MyString"
    confirmed false
  end
end
