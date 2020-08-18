class Diadema < ApplicationRecord
	validates_presence_of :fish_transect

	belongs_to :fish_transect
end
