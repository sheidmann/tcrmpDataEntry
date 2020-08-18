class Fish < ApplicationRecord
	validates_presence_of :common_name
	validates_presence_of :scientific_name
	validates_presence_of :code_name

	has_many :transect_fish

	def spp_code_common
    "#{code_name} __ #{common_name}"
  end
end
