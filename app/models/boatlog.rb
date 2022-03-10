require 'csv'

class Boatlog < ApplicationRecord
	validates_presence_of :site, :date_completed, :manager_id
	# validates_uniqueness_of :site_id, { scope: %i[date_completed begin_time], 
	# 	message: "duplicate boatlog"}

	belongs_to :manager
	accepts_nested_attributes_for :manager

	belongs_to :site
	accepts_nested_attributes_for :site

	has_many :boatlog_surveys, :dependent => :destroy, inverse_of: :boatlog
	accepts_nested_attributes_for :boatlog_surveys, :reject_if => :all_blank, :allow_destroy => true

	def countfishtran
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "fish transect").try(:id)).count
	end
	def countfishrov
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "fish rover").try(:id)).count
	end
	def countcoralhealth
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "coral health").try(:id)).count
	end
	def countalgaeht
		@childsurveys = self.boatlog_surveys.all
		@childsurveys.where(survey_type_id: SurveyType.find_by(type_name: "algae heights").try(:id)).count
	end

  def self.as_csv
    columns = %w(boatlog_id site_name date_completed type_name rep name)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |boatlog|
        site = boatlog.site
        boatlog.boatlog_surveys.each do |boatlog_survey|
          type = boatlog_survey.survey_type
          user = boatlog_survey.user
          csv << boatlog.attributes.merge(site.attributes).merge(user.attributes).merge(type.attributes).merge(boatlog_survey.attributes).values_at(*columns)
        end
      end
    end
  end
end
