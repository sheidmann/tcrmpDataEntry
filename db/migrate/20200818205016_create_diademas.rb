class CreateDiademas < ActiveRecord::Migration[6.0]
  def change
    create_table :diademas do |t|
    	t.references :fish_transect, index: true, foreign_key: true
    	t.integer :test_size_cm

      t.timestamps
    end
  end
end
