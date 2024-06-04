class AddProofingToESurvey < ActiveRecord::Migration[7.0]
  def change
    add_column :e_surveys, :buddy, :string
    add_column :e_surveys, :habitat, :string
    add_column :e_surveys, :proofed, :boolean, default: false
  end
end
