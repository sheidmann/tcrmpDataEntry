class Site < ApplicationRecord
	validates :site_name, presence: true, uniqueness: true

	has_many :boatlogs
	accepts_nested_attributes_for :boatlogs

	has_many :boatlog_surveys, :through => :boatlogs
	
	def fishtrancount
		@site_logs = Boatlog.where(site_id: self.id).all
		@site_logs.to_a.sum(&:countfishtran)
	end
	def fishrovcount
		@site_logs = Boatlog.where(site_id: self.id).all
		@site_logs.to_a.sum(&:countfishrov)
	end
	def coralhealthcount
		@site_logs = Boatlog.where(site_id: self.id).all
		@site_logs.to_a.sum(&:countcoralhealth)
	end
end
