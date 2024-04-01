class ChangeCoralDimsToDecimal < ActiveRecord::Migration[7.0]
  def up
   change_column :transect_corals, :length_cm, :decimal, using: 'length_cm::decimal', precision: 4, scale: 1
   change_column :transect_corals, :width_cm, :decimal, using: 'width_cm::decimal', precision: 4, scale: 1
   change_column :transect_corals, :height_cm, :decimal, using: 'height_cm::decimal', precision: 4, scale: 1
  end
  def down
   change_column :transect_corals, :length_cm, :integer, using: 'length_cm::integer'
   change_column :transect_corals, :width_cm, :integer, using: 'width_cm::integer'
   change_column :transect_corals, :height_cm, :integer, using: 'height_cm::integer'
  end
end
