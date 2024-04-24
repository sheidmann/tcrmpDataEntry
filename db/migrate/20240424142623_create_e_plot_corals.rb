class CreateEPlotCorals < ActiveRecord::Migration[7.0]
  def change
    create_table :e_plot_corals do |t|
      t.references :e_plot, index: true, foreign_key: true
      t.integer :quadrant
      t.references :coral_code, index: true, foreign_key: true
      t.decimal :max_diam, precision: 4, scale: 1
      t.integer :old_mortality
      t.integer :new_mortality
      t.string :disease
      t.text :notes

      t.timestamps
    end
  end
end
