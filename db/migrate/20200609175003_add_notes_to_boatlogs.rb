class AddNotesToBoatlogs < ActiveRecord::Migration[5.2]
  def change
  	add_column :boatlogs, :notes, :text
  end
end
