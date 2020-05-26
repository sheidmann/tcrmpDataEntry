class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
    	t.string :site_name
    	t.string :site_code
    	t.string :island
    	t.float :latitude
    	t.float :longitude
    	t.string :orientation
    	t.string :land
    	t.string :reef_complex
    	t.integer :depth_m

      t.timestamps
    end
  end
end
