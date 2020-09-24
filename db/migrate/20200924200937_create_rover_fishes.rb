class CreateRoverFishes < ActiveRecord::Migration[6.0]
  def change
    create_table :rover_fishes do |t|
    	t.references :fish_rover, index: true, foreign_key: true
    	t.references :fish, index: true, foreign_key: true
    	t.integer :abundance_index

      t.timestamps
    end
  end
end
