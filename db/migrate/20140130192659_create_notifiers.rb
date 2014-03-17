class CreateNotifiers < ActiveRecord::Migration
  def change
    create_table :notifiers do |t|
      t.string :user_id
      t.string :bills
    end
  end
end
