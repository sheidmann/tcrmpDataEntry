class EEsaPa < ApplicationRecord
	validates_presence_of :e_survey

  belongs_to :e_survey
end
