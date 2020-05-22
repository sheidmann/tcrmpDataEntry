class Boatlog < ApplicationRecord
	validates_presence_of :site, :date_completed, :begin_time, :manager_id
	validates_uniqueness_of :site, { scope: %i[date_completed begin_time], 
		message: "duplicate boatlog"}

	belongs_to  :manager
	accepts_nested_attributes_for :manager

	has_many :boatlog_surveys, :dependent => :destroy, inverse_of: :boatlog
	accepts_nested_attributes_for :boatlog_surveys, :allow_destroy => true
end
