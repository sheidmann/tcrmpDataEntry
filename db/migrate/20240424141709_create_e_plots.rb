class CreateEPlots < ActiveRecord::Migration[7.0]
  def change
    create_table :e_plots do |t|
      t.references :e_survey, index: true, foreign_key: true
      t.string :plot
      t.string :habitat
      t.integer :hardbottom
      t.decimal :max_relief_m, precision: 3, scale: 2
      t.integer :min_depth
      t.integer :max_depth

      t.timestamps
    end
  end
end
