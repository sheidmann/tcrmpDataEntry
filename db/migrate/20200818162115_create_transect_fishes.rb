class CreateTransectFishes < ActiveRecord::Migration[6.0]
  def change
    create_table :transect_fishes do |t|
    	t.references :fish_transect, index: true, foreign_key: true
    	t.references :fish, index: true, foreign_key: true
    	t.integer :x0to5
    	t.integer :x6to10
    	t.integer :x11to20
    	t.integer :x21to30
    	t.integer :x31to40
    	t.integer :xgt40

      t.timestamps
    end
  end
end
