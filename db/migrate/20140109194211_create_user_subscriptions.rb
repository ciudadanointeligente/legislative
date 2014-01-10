class CreateUserSubscriptions < ActiveRecord::Migration
  def change
    create_table :user_subscriptions do |t|
      t.string :user
      t.string :bill
      t.boolean :confirmed

      t.timestamps
    end
  end
end
