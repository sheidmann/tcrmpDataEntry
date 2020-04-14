class User < ApplicationRecord
	has_secure_password

	def admin?
		self.role == 'admin'
	end

	def manager?
		self.role == 'manager'
	end
end
