require 'csv'

class FishTransect < ApplicationRecord
	validates_presence_of :site, :manager, :user, :date_completed, :begin_time, :rep

	belongs_to :user

	belongs_to :site
	accepts_nested_attributes_for :site

	belongs_to :manager
	accepts_nested_attributes_for :manager

	has_many :transect_fishes, :dependent => :destroy, inverse_of: :fish_transect
	accepts_nested_attributes_for :transect_fishes, :reject_if => :all_blank, :allow_destroy => true

  has_many :fish, through: :transect_fishes
  accepts_nested_attributes_for :fish

	has_many :diademas, :dependent => :destroy, inverse_of: :fish_transect
	accepts_nested_attributes_for :diademas, :reject_if => :all_blank, :allow_destroy => true

	def countfishspecies
		self.transect_fishes.count
	end
	def countdiadema
		self.diademas.count
	end

  def self.as_csv
    columns = %w(site_name name date_completed begin_time rep oc_cc common_name scientific_name x0to5 x6to10 x11to20 x21to30 x31to40 x41to50 x51to60 x61to70 x71to80 x81to90 x91to100 x101to110 x111to120 x121to130 x131to140 x141to150 xgt150)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |fish_transect|
        site = fish_transect.site
        user = fish_transect.user
        fish_transect.transect_fishes.each do |transect_fish|
          fish = transect_fish.fish
          csv << fish_transect.attributes.merge(site.attributes).merge(user.attributes).merge(transect_fish.attributes).merge(fish.attributes).values_at(*columns)
        end
      end
    end
  end
end
