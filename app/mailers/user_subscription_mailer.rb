class UserSubscriptionMailer < ActionMailer::Base
  default from: "Congreso abierto <legislative@congresoabierto.cl>"

  def confirmation_email(user_subscription)
    @bill = user_subscription.bill
    @user = User.find_by_id(user_subscription.user)
    @user_subscription = user_subscription
    @url = 'http://www.congresoabierto.cl'
    mail(to: @user.email, subject: 'Congreso abierto, Confirmación de suscripción')
  end
end
