class CreateCoralCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :coral_codes do |t|
      t.string :code_name
      t.string :group
      t.string :category
      t.string :full_name

      t.timestamps
    end
  end
end
