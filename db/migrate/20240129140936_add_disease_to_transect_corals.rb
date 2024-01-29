class AddDiseaseToTransectCorals < ActiveRecord::Migration[7.0]
  def change
    add_column :transect_corals, :disease, :integer
  end
end
