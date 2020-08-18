class FishTransect < ApplicationRecord
	validates_presence_of :site, :manager, :user, :date_completed, :begin_time, :rep

	belongs_to :user

	belongs_to :site
	accepts_nested_attributes_for :site

	belongs_to :manager
	accepts_nested_attributes_for :manager

	has_many :transect_fish, :dependent => :destroy, inverse_of: :fish_transect
	accepts_nested_attributes_for :transect_fish, :reject_if => :all_blank, :allow_destroy => true

	has_many :diadema, :dependent => :destroy, inverse_of: :fish_transect
	accepts_nested_attributes_for :diadema, :reject_if => :all_blank, :allow_destroy => true

	def countfishspecies
		self.transect_fish.count
	end
	def countdiadema
		self.diadema.count
	end
end
