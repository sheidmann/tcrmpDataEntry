class Manager < ApplicationRecord
	validates_presence_of :manager_name, :project
	validates_uniqueness_of :manager_name, uniqueness: { scope: :project,
    message: "manager should not have a duplicate project" }
end
