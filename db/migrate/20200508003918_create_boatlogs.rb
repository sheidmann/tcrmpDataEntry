class CreateBoatlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :boatlogs do |t|
    	
    	t.string :site
    	t.date :date_completed
    	t.time :begin_time
    	t.string :manager_name

    	t.timestamps
    end
  end
end
