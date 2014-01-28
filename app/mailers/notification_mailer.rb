class NotificationMailer < ActionMailer::Base
  default from: "notifications@congresodechile.cl"

  def notify_bills_email(user_subscription, bills)
  	@user = User.find_by_id(user_subscription.user)
  	@bills = bills
  	mail(to: @user.email, subject: 'Congreso de Chile - Existen actualizaciones en tus suscripciones')
  end
end