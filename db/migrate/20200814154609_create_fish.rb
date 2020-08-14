class CreateFish < ActiveRecord::Migration[6.0]
  def change
    create_table :fish do |t|
    	t.string :common_name
    	t.string :scientific_name
    	t.string :code_name
    	t.string :family
    	t.string :troph
    	t.string :commercial
    	t.integer :min_size
    	t.integer :max_size
    	t.integer :max_num

      t.timestamps
    end
  end
end
