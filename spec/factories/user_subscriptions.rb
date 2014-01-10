# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_subscription do
    user 57
    bill "107-65"
    confirmed false
  end
end
