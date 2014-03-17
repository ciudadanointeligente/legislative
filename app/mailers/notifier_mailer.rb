class NotifierMailer < ActionMailer::Base
  default from: "Congreso abierto <legislative@congresoabierto.cl>"

  def notification_email(notifier)
  	@bills = notifier.bills
  	@user_id = notifier.user_id
  	@user_email = User.find_by_id(@user_id).email
  	@url = "http://www.congresoabierto.cl"
    mail(to: @user_email, subject: "Congreso abierto - Actualizaciones en proyectos de ley suscritos")
  end
end
