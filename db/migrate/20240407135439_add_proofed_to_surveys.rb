class AddProofedToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :fish_transects, :proofed, :boolean, default: false
    add_column :fish_rovers, :proofed, :boolean, default: false
    add_column :coral_healths, :proofed, :boolean, default: false
    add_column :algae_heights, :proofed, :boolean, default: false
  end
end
