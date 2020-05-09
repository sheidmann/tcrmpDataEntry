class CreateManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|

    	t.string :manager_name
    	t.string :project

    	t.timestamps
    end
  end
end
