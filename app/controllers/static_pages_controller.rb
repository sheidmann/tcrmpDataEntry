class StaticPagesController < ApplicationController
	before_action :require_user, only: [:userhome]

	def home
	end
	def about
	end
	def userhome
	end
end
