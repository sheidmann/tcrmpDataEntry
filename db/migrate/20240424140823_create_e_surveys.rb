class CreateESurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :e_surveys do |t|
      t.integer :fid
      t.references :user, index: true, foreign_key: true
      t.integer :team 
      t.string :role
      t.date :date_completed
      t.time :begin_time

      t.timestamps
    end
  end
end
