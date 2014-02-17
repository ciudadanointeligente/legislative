class NotifierMailer < ActionMailer::Base
  default from: "Legislativo <legislative@congresodechile.cl>"

  def notification_email(notifier)
  	@bills = notifier.bills
  	@user_id = notifier.user_id
  	@user_email = User.find_by_id(@user_id).email
  	@url = "http://www.congresoabierto.cl"
  	mail(to: @user_email, subject: "Congreso Abierto - Actualizaciones en Proyectos de Ley suscritos")
  end
  	
end
