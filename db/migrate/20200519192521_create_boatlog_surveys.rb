class CreateBoatlogSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :boatlog_surveys do |t|
    	t.references :boatlog, index: true, foreign_key: true
    	t.references :user, index: true, foreign_key: true
    	t.references :survey_type, index: true, foreign_key: true
    	t.integer :rep

      t.timestamps
    end
  end
end
