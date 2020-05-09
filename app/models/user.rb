class User < ApplicationRecord
	has_secure_password validations: false

	validates :name, presence: true, uniqueness: true
	validates_presence_of :role

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
end
