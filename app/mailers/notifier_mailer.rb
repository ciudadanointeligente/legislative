class NotifierMailer < ActionMailer::Base
  default from: ENV['email_suscription']

  def notification_email(notifier)
  	@bills = notifier.bills
  	@user_id = notifier.user_id
  	@user_email = User.find_by_id(@user_id).email
  	@url = ENV['url_suscription']
    mail(to: @user_email, subject: ENV['subject_update'])
  end
end
