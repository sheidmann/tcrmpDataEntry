class FishTransectsController < ApplicationController
	before_action :require_user

	# Create a new fish transect
	def new
		@ftran = FishTransect.new
		@ftran.transect_fish.build
	end

	def create
		@ftran = FishTransect.new( fish_transect_params )
	end

	private

	def fish_transect_params
		params.require(:fish_transect).permit(:manager_id, :site_id, :user_id, :date_completed, :begin_time, :rep, :completed_m, :notes, :oc_cc, transect_fishes_attributes: [:id, :fish_id, :x0to5, :x6to10, :x11to20, :x21to30, :x31to40, :xgt40, :_destroy])
	end
end
