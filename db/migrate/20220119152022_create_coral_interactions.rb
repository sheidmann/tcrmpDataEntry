class CreateCoralInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :coral_interactions do |t|
      t.references :transect_coral, index: true, foreign_key: true
      t.references :coral_code, index: true, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
