class AddUserToManagers < ActiveRecord::Migration[5.2]
  def change
    add_reference :managers, :user, foreign_key: true
    remove_column :managers, :manager_name
  end
end
