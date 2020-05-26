class AddSiteToBoatlogs < ActiveRecord::Migration[5.2]
  def change
  	add_reference :boatlogs, :site, foreign_key: true
  	remove_column :boatlogs, :site
  end
end
