require 'csv'

class EPlotCoral < ApplicationRecord
	validates_presence_of :e_plot, :coral_code

  belongs_to :e_plot
  accepts_nested_attributes_for :e_plot
  
  belongs_to :coral_code
  accepts_nested_attributes_for :coral_code

  def self.as_csv
    columns = %w(fid date_completed diver team role site_notes plot quadrant species species_code length old_mort rec_mort disease field_notes)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |epc|
        esurv = epc.e_plot.e_survey
        diver = esurv.user
        csv << [esurv.fid, esurv.date_completed, diver.name, esurv.team, esurv.role, esurv.notes, epc.e_plot.plot, epc.quadrant, epc.coral_code.full_name, epc.coral_code.long_code, epc.max_diam, epc.old_mortality, epc.new_mortality, epc.disease, epc.notes]
      end
    end
  end
end
