class EBoatlogTeam < ApplicationRecord
	validates_presence_of :e_boatlog, :user_id, :team, :role

	belongs_to :e_boatlog
	belongs_to :user
	accepts_nested_attributes_for :user
end
