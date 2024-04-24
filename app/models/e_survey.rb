class ESurvey < ApplicationRecord
	validates_presence_of :fid, :user, :team, :role, :date_completed

	belongs_to :user
end
