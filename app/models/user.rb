class User < ApplicationRecord
	has_secure_password validations: false

	validates :name, presence: true, uniqueness: true
	validates_presence_of :role

	def admin?
		self.role == "admin"
	end

	def manager?
		self.role == "manager"
	end

	def username
    	"#{name.downcase}"
	end
	def password
		"#{name.downcase}"
	end
end
