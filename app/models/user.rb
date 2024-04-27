require 'csv'

class User < ApplicationRecord
	has_secure_password validations: false

	validates :name, presence: true, uniqueness: true
	validates_presence_of :role

	has_many :managers
	has_many :boatlog_surveys
	has_many :fish_transects
	has_many :fish_rovers
  has_many :coral_healths
  has_many :algae_heights

  has_many :e_boatlog_surveys
  has_many :e_surveys

	# Automatically make username and password from name
	before_create :check_params

	def check_params   
	   self.name.upcase! 
	   self.username = self.name.downcase
	   self.password = self.name.downcase    
	end

	def active?
		self.active == "true"
	end

	def admin?
		self.role == "admin"
	end

	def manager?
		self.role == "manager" || self.role == "admin"
	end

	def project
		if self.role == "manager"
			Manager.find_by(user_id: self.id).try(:project)
		elsif self.role == "admin"
			"all"
		else
			nil
		end
	end

	def self.as_csv
		columns = %w(id name agency active role)
    CSV.generate(headers: true) do |csv|
			csv << columns.map(&:humanize)
			all.each do |user|
				csv << user.attributes.values_at(*columns)
			end
		end
	end
end
