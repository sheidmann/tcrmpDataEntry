class AddBlSpToTransectCorals < ActiveRecord::Migration[7.0]
  def change
    add_column :transect_corals, :bl_sp, :integer
    add_column :transect_corals, :bl_p, :integer
    add_column :transect_corals, :bl_vp, :integer
    add_column :transect_corals, :bl_bl, :integer
    remove_column :transect_corals, :damage
  end
end
