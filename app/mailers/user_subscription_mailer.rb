class UserSubscriptionMailer < ActionMailer::Base
  default from: ENV['email_suscription']

  def confirmation_email(user_subscription)
    @bill = user_subscription.bill
    @user = User.find_by_id(user_subscription.user)
    @user_subscription = user_subscription
    @url = ENV['url_suscription']
    mail(to: @user.email, subject: ENV['subject_suscription'])
  end
end
