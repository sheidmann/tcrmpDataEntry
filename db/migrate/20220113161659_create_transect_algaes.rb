class CreateTransectAlgaes < ActiveRecord::Migration[6.0]
  def change
    create_table :transect_algaes do |t|
      t.references :algae_height, index: true, foreign_key: true
      t.references :algae, index: true, foreign_key: true
      t.decimal :height_cm

      t.timestamps
    end
  end
end
