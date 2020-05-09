class Boatlog < ApplicationRecord
	validates_presence_of :site, :date_completed, :begin_time, :manager_name
	validates_uniqueness_of :site, { scope: %i[date_completed begin_time], 
		message: "duplicate boatlog"}

	#belongs_to  :manager
end
