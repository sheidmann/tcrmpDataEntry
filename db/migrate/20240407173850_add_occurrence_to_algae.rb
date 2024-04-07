class AddOccurrenceToAlgae < ActiveRecord::Migration[7.0]
  def change
    add_column :algaes, :occurrence, :integer
  end
end
