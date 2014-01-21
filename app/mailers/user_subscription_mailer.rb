class UserSubscriptionMailer < ActionMailer::Base
  default from: "legislative@ciudadanointeligente.org"

  def confirmation_email(user_subscription)
  	@bill = user_subscription.bill
  	@user = User.find_by_id(user_subscription.user)
  	@user_subscription = user_subscription
  	@url = 'http://beta.congresodechile.cl'
  	mail(to: @user.email, subject: 'Congreso Abierto, Confirmación de Suscripción')
  end
end
