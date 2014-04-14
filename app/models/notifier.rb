class Notifier < ActiveRecord::Base
  attr_accessible :user_id, :bills
  serialize :bills, Array

  validates_uniqueness_of :user_id

  def send_notifies
    @notifies = Notifier.all
    @time_now = Time.now()
    @notifies.each do |notify|
      NotifierMailer.notification_email(notify).deliver

      @user = User.find_by_id(notify.user_id)
      @user.last_notification = @time_now
      @user.save

      Notifier.delete_all(["user_id = ?", notify.user_id])
    end

    Rails.logger.debug "Task - Notifications sent!"
  end
end