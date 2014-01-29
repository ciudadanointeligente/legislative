require 'spec_helper'

describe NotifiersController do

	describe "notify user" do
		before (:each) do
			@user_subs1 = FactoryGirl.build(:user_subscription1) 
			@user_subs2 = FactoryGirl.build(:user_subscription2) 
			@user_subs3 = FactoryGirl.build(:user_subscription3)
		end
		it "obtain subscriptions from bill" do
			@bill = "9024-07"
			get :get_user_id_subscriptions, id: @bill
			assigns(:users_id_subscribed).should eq([35, 12])
		end
	end

end
