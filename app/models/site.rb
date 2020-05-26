class Site < ApplicationRecord
	validates :site_name, presence: true, uniqueness: true

	has_many :boatlogs
end
