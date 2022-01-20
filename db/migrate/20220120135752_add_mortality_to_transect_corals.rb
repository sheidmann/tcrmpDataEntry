class AddMortalityToTransectCorals < ActiveRecord::Migration[6.0]
  def change
    add_column :transect_corals, :old_mortality, :integer
    add_column :transect_corals, :new_mortality, :integer
    add_column :transect_corals, :notes, :text
  end
end
