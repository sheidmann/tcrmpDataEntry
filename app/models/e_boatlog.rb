class EBoatlog < ApplicationRecord
	validates_presence_of :fid, :date_completed

	has_many :e_boatlog_teams, :dependent => :destroy, inverse_of: :boatlog
	accepts_nested_attributes_for :e_boatlog_teams, :reject_if => :all_blank, :allow_destroy => true
end
