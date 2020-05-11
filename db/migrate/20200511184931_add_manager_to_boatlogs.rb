class AddManagerToBoatlogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :boatlogs, :manager, foreign_key: true
    remove_column :boatlogs, :manager_name
  end
end
