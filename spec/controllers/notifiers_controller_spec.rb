require 'spec_helper'

describe NotifiersController do

	describe "notify user" do
		xit "obtain subscriptions from bill" do
			@user_subs1 = FactoryGirl.build(:user_subscription1) 
			@user_subs2 = FactoryGirl.build(:user_subscription2) 
			@user_subs3 = FactoryGirl.build(:user_subscription3)
			@user_subs4 = FactoryGirl.build(:user_subscription4)
			@bill = "9024-07"
			get :get_user_id_subscriptions, id: @bill
			assigns(:users_id_subscribed).should eq(["35", "12"])
		end
		xit "builds a notifier with variuos bills" do
			@bill1 = "9024-07"
			@users_subscribed_to_bill1 = [35, 12]
			post :create, bill: @bill1, users_id_subscribed: @users_subscribed_to_bill1
			@bill2 = "8906-09"
			@users_subscribed_to_bill2 = [12]
			post :create, bill: @bill2, users_id_subscribed: @users_subscribed_to_bill2
			
			@notifier = Notifier.find_by_user_id(12)
			@notifier.bills.should eq(["9024-07", "8906-09"])
		end


	end

end
