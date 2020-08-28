class Boatlog < ApplicationRecord
	validates_presence_of :site, :date_completed, :begin_time, :manager_id
	validates_uniqueness_of :site_id, { scope: %i[date_completed begin_time], 
		message: "duplicate boatlog"}

	belongs_to :manager
	accepts_nested_attributes_for :manager

	belongs_to :site
	accepts_nested_attributes_for :site

	has_many :boatlog_surveys, :dependent => :destroy, inverse_of: :boatlog
	accepts_nested_attributes_for :boatlog_surveys, :reject_if => :all_blank, :allow_destroy => true

	def countfishtran
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "fish transect").id).count
	end
	def countfishrov
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "fish rover").id).count
	end
	def countcoralhealth
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "coral health").id).count
	end
	def countalgaeht
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "algae heights").id).count
	end
end
