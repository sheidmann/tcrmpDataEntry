class TransectFish < ApplicationRecord
	validates_presence_of :fish_transect, :fish

	belongs_to :fish_transect

	belongs_to :fish
	accepts_nested_attributes_for :fish

	def speciestotal
		self.x0to5 + self.x6to10 + self.x11to20 + self.x21to30 + self.x31to40 + self.xgt40
	end
end
