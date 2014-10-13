class AddSearchableToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :searchable, :boolean
  end
end
