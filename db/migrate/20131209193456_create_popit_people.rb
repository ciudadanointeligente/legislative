class CreatePopitPeople < ActiveRecord::Migration
  def change
    create_table :popit_people do |t|

      t.timestamps
    end
  end
end
