class AddEmailTokenToUserSubscriptions < ActiveRecord::Migration
  def change
    add_column :user_subscriptions, :email_token, :string
  end
end
