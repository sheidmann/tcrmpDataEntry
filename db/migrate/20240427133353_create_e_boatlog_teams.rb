class CreateEBoatlogTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :e_boatlog_teams do |t|

      t.references :e_boatlog, index: true, foreign_key: true
      t.integer :team
      t.references :user, index: true, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
