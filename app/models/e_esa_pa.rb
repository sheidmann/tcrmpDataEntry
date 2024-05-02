require 'csv'

class EEsaPa < ApplicationRecord
	validates_presence_of :e_survey

  belongs_to :e_survey
  accepts_nested_attributes_for :e_survey

  def self.as_csv
    columns = %w(fid date_completed diver team role oann ofra ofav apal apro acer dcyl mfer mmea dsto efas dead_apal dead_dcyl rami)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |esa|
        esurv = esa.e_survey
        diver = esurv.user
        csv << [esurv.fid, esurv.date_completed, diver.name, esurv.team, esurv.role, esa.oann, esa.ofra, esa.ofav, esa.apal, esa.apro, esa.acer, esa.dcyl, esa.mfer, esa.mmea, esa.dsto, esa.efas, esa.dead_APAL, esa.dead_DCYL, esa.rami]
      end
    end
  end
end
