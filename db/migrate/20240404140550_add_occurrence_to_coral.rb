class AddOccurrenceToCoral < ActiveRecord::Migration[7.0]
  def change
    add_column :coral_codes, :occurrence, :integer
    add_column :coral_codes, :long_code, :string
    add_column :coral_codes, :max_diam, :decimal, precision: 4, scale: 1
    add_column :coral_codes, :max_height, :decimal, precision: 4, scale: 1
  end
end
