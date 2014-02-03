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
  		f.confirmed true
  		f.email_token 108
  	end
    factory :user_subscription3 do |f|
      f.user 12
      f.bill "9024-07"
      f.confirmed true
      f.email_token 473910
    end
    factory :user_subscription4 do |f|
      f.user 12
      f.bill "8906-09"
      f.confirmed true
      f.email_token 294881
    end
  end
end
