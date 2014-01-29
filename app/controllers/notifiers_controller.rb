class NotifiersController < ApplicationController

	def get_user_id_subscriptions
		@bill = params[:id]
		@users_subscribed = UserSubscription.where(bill: @bill).to_a
		@users_id_subscribed = @users_subscribed.map { |user| user.user.to_i }

		render text: @users_id_subscribed
	end

end
