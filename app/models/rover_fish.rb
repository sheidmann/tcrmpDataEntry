class RoverFish < ApplicationRecord
	validates_presence_of :fish_rover, :fish

	belongs_to :fish_rover

	belongs_to :fish
	accepts_nested_attributes_for :fish
end
