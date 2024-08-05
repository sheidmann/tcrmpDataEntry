class FishRover < ApplicationRecord
	validates_presence_of :site, :manager, :user, :date_completed, :rep

	belongs_to :user

	belongs_to :site
	accepts_nested_attributes_for :site

	belongs_to :manager
	accepts_nested_attributes_for :manager

	has_many :rover_fishes, :dependent => :destroy, inverse_of: :fish_rover
	accepts_nested_attributes_for :rover_fishes, :reject_if => :all_blank, :allow_destroy => true

  has_many :fish, through: :rover_fishes
  accepts_nested_attributes_for :fish

	def countfishspecies
		self.rover_fishes.count
	end

  def self.as_csv
    columns = %w(fish_rover_id proofed site_name date_completed name rep oc_cc notes common_name scientific_name abundance_index)
    CSV.generate(headers: true) do |csv|
      csv << columns.map(&:humanize)
      all.each do |fish_rover|
        site = fish_rover.site
        user = fish_rover.user
        fish_rover.rover_fishes.each do |rover_fish|
          fish = rover_fish.fish
          csv << fish_rover.attributes.merge(site.attributes).merge(user.attributes).merge(rover_fish.attributes).merge(fish.attributes).values_at(*columns)
        end
      end
    end
  end
end
