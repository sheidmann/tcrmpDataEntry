class TransectFish < ApplicationRecord
	validates_presence_of :fish_transect, :fish

	belongs_to :fish_transect

	belongs_to :fish
	accepts_nested_attributes_for :fish
end
