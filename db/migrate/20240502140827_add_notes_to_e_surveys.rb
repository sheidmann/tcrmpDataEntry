class AddNotesToESurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :e_surveys, :notes, :text
  end
end
