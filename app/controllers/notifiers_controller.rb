class NotifiersController < ApplicationController

	# GET /bill/get_user_id_subscriptions
	def get_user_id_subscriptions
		@bill = params[:id]
		@users_subscribed = UserSubscription.where(bill: @bill).to_a
		@users_id_subscribed = @users_subscribed.find_all { |user| user.confirmed == true }
		@users_id_subscribed = @users_subscribed.map { |user| user.user }

		render text: @users_id_subscribed
	end

	# ṔOST /create?bill=bill&users_id_subscribed=users
	def create
		@bill = params[:bill]
		@users_id_subscribed = params[:users_id_subscribed]

		@users_id_subscribed.each do |user_id|
			notifier = Notifier.find_by_user_id(user_id)
			if notifier.nil?
				Notifier.create(:user_id => user_id, :bills => [@bill])
			else
				notifier.bills << @bill
				notifier.save
			end
		end

		render text: @bill
	end

	def send_notifies
		@notifies = Notifier.all
		@notifies.each do |notify|
			NotifierMailer.notification_email(notify).deliver
		end
		# Remove notifies from database
	end

end
