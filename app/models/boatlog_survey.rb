class BoatlogSurvey < ApplicationRecord
	validates_presence_of :boatlog_id, :user_id, :survey_type_id, :rep
	validates_uniqueness_of :rep, { scope: %i[boatlog_id user_id survey_type_id], 
		message: "duplicate survey"}

	belongs_to :boatlog
	belongs_to :user
	accepts_nested_attributes_for :user
	belongs_to :survey_type
	accepts_nested_attributes_for :survey_type
end
