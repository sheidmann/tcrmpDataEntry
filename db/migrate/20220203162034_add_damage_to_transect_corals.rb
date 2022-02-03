class AddDamageToTransectCorals < ActiveRecord::Migration[6.0]
  def change
    add_column :transect_corals, :damage, :boolean, null: false, default: false
  end
end
