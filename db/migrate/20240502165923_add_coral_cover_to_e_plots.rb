class AddCoralCoverToEPlots < ActiveRecord::Migration[7.0]
  def change
    add_column :e_plots, :coral_cover, :integer
  end
end
