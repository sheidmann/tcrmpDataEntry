require 'csv'

class CoralHealth < ApplicationRecord
  validates_presence_of :site, :manager, :user, :date_completed, :rep

  belongs_to :user

  belongs_to :site
  accepts_nested_attributes_for :site

  belongs_to :manager
  accepts_nested_attributes_for :manager

  has_many :transect_corals, :dependent => :destroy, inverse_of: :coral_health
  accepts_nested_attributes_for :transect_corals, :reject_if => :all_blank, :allow_destroy => true

  has_many :coral_codes, through: :transect_corals
  accepts_nested_attributes_for :coral_codes

  has_many :coral_interactions, through: :transect_corals
  accepts_nested_attributes_for :coral_interactions

  def countcorals
    self.transect_corals.count
  end

  def self.as_csv
    columns = %w(ID site_name date_completed observer rep transect_coral_id coral_name length_cm width_cm height_cm old_mortality recent_mortality interaction_name interaction_value)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |coral_health|
        site = coral_health.site
        user = coral_health.user
        coral_health.transect_corals.each do |transect_coral|
          coral = transect_coral.coral_code
          # Create the row through coral dimensions
          row_coral = [coral_health.id, site.site_name, coral_health.date_completed, user.name, coral_health.rep, transect_coral.id, coral.code_name, transect_coral.length_cm, transect_coral.width_cm, transect_coral.height_cm, transect_coral.old_mortality, transect_coral.new_mortality]
          # Leave interaction columns empty if none
          if transect_coral.coral_interactions.count == 0
            csv << row_coral
          else
            # Otherwise add a full row for each interaction
            transect_coral.coral_interactions.each do |coral_interaction|
              interaction = coral_interaction.coral_code
              csv << row_coral + [interaction.code_name] + [coral_interaction.value]
            end
          end
        end
      end
    end
  end
end
