class TransectFish < ApplicationRecord
	validates_presence_of :fish_transect, :fish

	belongs_to :fish_transect

	belongs_to :fish
	accepts_nested_attributes_for :fish

	def speciestotal
		self.x0to5 + self.x6to10 + self.x11to20 + self.x21to30 + self.x31to40 + self.x41to50 + self.x51to60 + self.x61to70 + self.x71to80 + self.x81to90 + self.x91to100 + self.x101to110 + self.x111to120 + self.x131to140 + self.x141to150 + self.xgt150
	end
end
