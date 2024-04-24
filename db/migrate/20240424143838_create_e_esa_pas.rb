class CreateEEsaPas < ActiveRecord::Migration[7.0]
  def change
    create_table :e_esa_pas do |t|
      t.references :e_survey, index: true, foreign_key: true
      t.string :oann
      t.string :ofav
      t.string :ofra
      t.string :apal
      t.string :acer
      t.string :dcyl
      t.string :mfer
      t.string :mmea
      t.string :dsto
      t.string :efas
      t.string :dead_APAL
      t.string :dead_DCYL
      t.string :rami

      t.timestamps
    end
  end
end
