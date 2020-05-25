class SurveyType < ApplicationRecord
	has_many :boatlog_surveys
	validates_uniqueness_of :type_name
end
