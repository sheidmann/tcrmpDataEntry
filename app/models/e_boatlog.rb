require 'csv'

class EBoatlog < ApplicationRecord
	validates_presence_of :fid, :date_completed

	has_many :e_boatlog_teams, :dependent => :destroy, inverse_of: :e_boatlog
	accepts_nested_attributes_for :e_boatlog_teams, :reject_if => :all_blank, :allow_destroy => true

	def self.as_csv
    columns = %w(fid date_completed captain dod latitude longitude team role name time_in time_out depth_ft hss disease notes)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |ebl|
        ebl.e_boatlog_teams.each do |eblt|
          user = eblt.user
          # csv << ebl.attributes.merge(eblt.attributes).merge(user.attributes).values_at(*columns) # picks user.role instead of e_boatlog_team.role
          csv << [ebl.fid, ebl.date_completed, ebl.captain, ebl.dod, ebl.latitude, ebl.longitude, eblt.team, eblt.role, eblt.user.name, ebl.try(:time_in).try(:strftime, "%H:%M"), ebl.try(:time_out).try(:strftime, "%H:%M"), ebl.depth_ft, ebl.hss, ebl.disease, ebl.notes]
        end
      end
    end
  end
end
