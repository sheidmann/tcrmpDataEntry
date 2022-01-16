class CreateCoralHealths < ActiveRecord::Migration[6.0]
  def change
    create_table :coral_healths do |t|
      t.references :manager, index: true, foreign_key: true
      t.references :site, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :date_completed
      t.integer :rep
      t.text :notes

      t.timestamps
    end
  end
end
