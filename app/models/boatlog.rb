class Boatlog < ApplicationRecord
	validates_presence_of :site, :date_completed, :begin_time, :manager_name
end
