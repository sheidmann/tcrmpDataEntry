class AddOccurrenceToFish < ActiveRecord::Migration[7.0]
  def change
    add_column :fish, :occurrence, :integer
  end
end
