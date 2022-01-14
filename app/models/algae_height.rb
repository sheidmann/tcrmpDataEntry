require 'csv'

class AlgaeHeight < ApplicationRecord
  validates_presence_of :site, :manager, :user, :date_completed, :rep

  belongs_to :user

  belongs_to :site
  accepts_nested_attributes_for :site

  belongs_to :manager
  accepts_nested_attributes_for :manager

  has_many :transect_algaes, :dependent => :destroy, inverse_of: :algae_height
  accepts_nested_attributes_for :transect_algaes, :reject_if => :all_blank, :allow_destroy => true

  has_many :algaes, through: :transect_algaes
  accepts_nested_attributes_for :algaes

  def self.as_csv
    columns = %w(algae_height_id site_name date_completed name rep code_name full_name height_cm)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |algae_height|
        site = algae_height.site
        user = algae_height.user
        algae_height.transect_algaes.each do |transect_algae|
          algae = transect_algae.algae
          csv << algae_height.attributes.merge(site.attributes).merge(user.attributes).merge(transect_algae.attributes).merge(algae.attributes).values_at(*columns)
        end
      end
    end
  end
end
