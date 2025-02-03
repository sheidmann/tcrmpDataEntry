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
    columns = %w(coral_health_id proofed site_name date_completed method name rep site_notes transect_coral_id coral_code_name coral_full_name length_cm width_cm height_cm bl_sp bl_p bl_vp bl_bl old_mortality recent_mortality coral_notes interaction_name interaction_value)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |coral_health|
        site = coral_health.site
        user = coral_health.user
        coral_health.transect_corals.each do |transect_coral|
          coral = transect_coral.coral_code
          # Create the row through coral dimensions
          row_coral = [coral_health.id, coral_health.proofed, site.site_name, coral_health.date_completed, coral_health.method, user.name, coral_health.rep, coral_health.notes, transect_coral.id, coral.code_name, coral.full_name, transect_coral.length_cm, transect_coral.width_cm, transect_coral.height_cm, transect_coral.bl_sp, transect_coral.bl_p, transect_coral.bl_vp, transect_coral.bl_bl, transect_coral.old_mortality, transect_coral.new_mortality, transect_coral.notes]
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
