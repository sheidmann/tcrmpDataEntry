class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true, uniqueness: true
	validates_presence_of :role

	def admin?
		self.role == 'admin'
	end

	def manager?
		self.role == 'manager'
	end
end
