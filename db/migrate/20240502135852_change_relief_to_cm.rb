class ChangeReliefToCm < ActiveRecord::Migration[7.0]
  def change
    add_column :e_plots, :max_relief_cm, :integer
    remove_column :e_plots, :max_relief_m
  end
end
