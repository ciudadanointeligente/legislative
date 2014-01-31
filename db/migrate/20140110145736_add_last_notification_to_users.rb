class AddLastNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_notification, :date
  end
end
