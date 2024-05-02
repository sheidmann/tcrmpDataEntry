class AddAproToEsa < ActiveRecord::Migration[7.0]
  def change
    add_column :e_esa_pas, :apro, :string
  end
end
