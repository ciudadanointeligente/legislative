class Notifier < ActiveRecord::Base
  attr_accessible :user_id, :bills
  serialize :bills, Array

  validates_uniqueness_of :user_id

  def self.task_send_notifies
    # It runs all the tasks according to notify users with updates on bills
    notifications = NotifiersController.new
    @bills = notifications.bills_updated(Date.today.to_s)
    @bills.each do |bill|
      @user_id_subscriptions = notifications.get_user_id_subscriptions(bill)
      notifications.build(bill, @user_id_subscriptions)
    end
    notifications.send_notifies

    Rails.logger.debug "Task - Notifications sent!"
  end
end
