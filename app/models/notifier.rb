class Notifier < ActiveRecord::Base
  attr_accessible :user_id, :bills
  serialize :bills, Array

  validates_uniqueness_of :user_id

  def task_send_notifies
    # It runs all the tasks according to notify users with updates on bills
    @bills = NotifiersController.bills_updated(Date.today.to_s)
    @bills.each do |bill|
      @user_id_subscriptions = NotifiersController.get_user_id_subscriptions(bill)
      build(bill, @user_id_subscriptions)
    end
    NotifiersController.send_notifies

    Rails.logger.debug "Task - Notifications sent!"
  end
end