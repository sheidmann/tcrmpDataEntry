require 'csv'

class EPlot < ApplicationRecord
	validates_presence_of :e_survey, :plot

	belongs_to :e_survey
	accepts_nested_attributes_for :e_survey

	has_many :e_plot_corals, :dependent => :destroy, inverse_of: :e_plot
  accepts_nested_attributes_for :e_plot_corals, :reject_if => :all_blank, :allow_destroy => true

  def self.as_csv
    columns = %w(fid proofed date_completed diver buddy team role habitat plot hardbottom coral_cover max_vert_relief_cm min_depth max_depth)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |p|
        esurv = p.e_survey
        diver = esurv.user
        csv << [esurv.fid, esurv.proofed, esurv.date_completed, diver.name, esurv.buddy, esurv.team, esurv.role, esurv.habitat, p.plot, p.hardbottom, p.coral_cover, p.max_relief_cm, p.min_depth, p.max_depth]
      end
    end
  end
end
