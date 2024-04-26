class EEsaPa < ApplicationRecord
	validates_presence_of :e_survey

  belongs_to :e_survey
  accepts_nested_attributes_for :e_survey
end
