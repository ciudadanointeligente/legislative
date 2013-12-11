class CreatePopitPersonCollections < ActiveRecord::Migration
  def change
    create_table :popit_person_collections do |t|

      t.timestamps
    end
  end
end
