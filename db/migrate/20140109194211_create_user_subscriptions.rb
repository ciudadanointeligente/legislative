class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|
      t.string :user_email
      t.string :bill
      t.boolean :confirmed

      t.timestamps
    end
  end
end
