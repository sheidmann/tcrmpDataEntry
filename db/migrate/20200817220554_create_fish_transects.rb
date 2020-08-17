class CreateFishTransects < ActiveRecord::Migration[6.0]
  def change
    create_table :fish_transects do |t|
    	t.references :manager, index: true, foreign_key: true
    	t.references :site, index: true, foreign_key: true
    	t.references :user, index: true, foreign_key: true
    	t.date :date_completed
    	t.time :begin_time
    	t.integer :rep 
    	t.integer :completed_m
    	t.text :notes

      t.timestamps
    end
  end
end
