class AddBigFishSizes < ActiveRecord::Migration[6.0]
  def change
    rename_column :transect_fishes, :xgt40, :x41to50
    add_column :transect_fishes, :x51to60, :integer
    add_column :transect_fishes, :x61to70, :integer
    add_column :transect_fishes, :x71to80, :integer
    add_column :transect_fishes, :x81to90, :integer
    add_column :transect_fishes, :x91to100, :integer
    add_column :transect_fishes, :x101to110, :integer
    add_column :transect_fishes, :x111to120, :integer
    add_column :transect_fishes, :x121to130, :integer
    add_column :transect_fishes, :x131to140, :integer
    add_column :transect_fishes, :x141to150, :integer
    add_column :transect_fishes, :xgt150, :integer
  end
end
