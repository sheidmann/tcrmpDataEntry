class CreateEBoatlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :e_boatlogs do |t|

      t.integer :fid
      t.date :date_completed
      t.string :captain
      t.integer :dod
      t.decimal :latitude, precision: 7, scale: 5
      t.decimal :longitude, precision: 7, scale: 5
      t.time :time_in
      t.time :time_out
      t.integer :depth_ft
      t.string :hss
      t.string :disease
      t.text :notes

      t.timestamps
    end
  end
end
