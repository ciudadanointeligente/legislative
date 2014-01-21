FactoryGirl.define do
  factory :user_subscription do
  	factory :user_subscription1 do |f|
    	f.user 57
    	f.bill "107-65"
    	f.confirmed false
    	f.email_token 10
  	end
  	factory :user_subscription2 do |f|
  		f.user 35
  		f.bill "9024-07"
  		f.confirmed false
  		f.email_token 108
  	end
  end
end
