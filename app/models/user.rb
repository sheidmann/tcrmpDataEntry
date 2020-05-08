class User < ApplicationRecord
	has_secure_password validations: false

	validates :name, presence: true, uniqueness: true
	validates_presence_of :role

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
