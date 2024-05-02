class AddEcmpTargetToCoralCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :coral_codes, :ecmp_target, :string
  end
end
