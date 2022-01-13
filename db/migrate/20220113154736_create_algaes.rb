class CreateAlgaes < ActiveRecord::Migration[6.0]
  def change
    create_table :algaes do |t|
      t.string :code_name
      t.string :full_name

      t.timestamps
    end
  end
end
