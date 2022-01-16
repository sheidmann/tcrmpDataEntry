class CreateTransectCorals < ActiveRecord::Migration[6.0]
  def change
    create_table :transect_corals do |t|
      t.references :coral_health, index: true, foreign_key: true
      t.references :coral_code, index: true, foreign_key: true
      t.integer :length_cm
      t.integer :width_cm
      t.integer :height_cm

      t.timestamps
    end
  end
end
