class AddOcCcToFishTransect < ActiveRecord::Migration[6.0]
  def change
    add_column :fish_transects, :oc_cc, :string
  end
end
