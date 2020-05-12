class StaticPagesController < ApplicationController
	before_action :require_user, only: [:userhome]

	# Homepage (root)
	def home
	end
	
	# About page
	def about
	end

	# User homepage
	def userhome
	end

	# Survey placeholder
	def placeholder
	end
end
