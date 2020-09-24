class FishRover < ApplicationRecord
	validates_presence_of :site, :manager, :user, :date_completed, :begin_time, :rep

	belongs_to :user

	belongs_to :site
	accepts_nested_attributes_for :site

	belongs_to :manager
	accepts_nested_attributes_for :manager

	has_many :rover_fishes, :dependent => :destroy, inverse_of: :fish_rover
	accepts_nested_attributes_for :rover_fishes, :reject_if => :all_blank, :allow_destroy => true

	def countfishspecies
		self.rover_fishes.count
	end
end
