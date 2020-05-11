class Manager < ApplicationRecord
	validates_presence_of :user_id, :project
	validates_uniqueness_of :user_id, uniqueness: { scope: :project,
    message: "manager should not have a duplicate project" }


    belongs_to :user
    accepts_nested_attributes_for :user

    has_many :boatlogs
end
