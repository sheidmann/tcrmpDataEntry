class BoatlogSurveyController < ApplicationController
	before_action :require_manager

	private

	def boatlog_survey_params
		params.require(:boatlog_survey).permit(:boatlog_id, :user_id, :survey_type_id, :rep)
	end
end
