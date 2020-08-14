class Fish < ApplicationRecord
	def spp_code_common
    "#{code_name} __ #{common_name}"
  end
end
