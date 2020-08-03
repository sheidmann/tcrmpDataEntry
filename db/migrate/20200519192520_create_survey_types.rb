class CreateSurveyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_types do |t|
    	t.string :type_name
    	t.string :category
    	t.string :units

      t.timestamps
    end
  end
end
