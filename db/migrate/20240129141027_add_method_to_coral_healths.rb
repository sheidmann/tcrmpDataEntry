class AddMethodToCoralHealths < ActiveRecord::Migration[7.0]
  def change
    add_column :coral_healths, :method, :string
  end
end
