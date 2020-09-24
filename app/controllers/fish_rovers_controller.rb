class FishRoversController < ApplicationController
	before_action :require_user

	# Create a new fish rover
	def new
		@frove = FishRover.new

		respond_to do |format|
  		format.html # new.html.erb
  		format.json { render json: @frove }
  	end
	end

	# View all of a user's fish rovers
	def index
		@new_frove = FishRover.new # use in the view to render a form
		# Only show rovers
		@frove = @current_user.fish_rovers.order(date_completed: :asc).all

    respond_to do |format|
      format.html # index.html.erb
    end
	end

  private

	def fish_rover_params
		params.require(:fish_rover).permit(:manager_id, :site_id, :user_id, 
			:date_completed, :begin_time, :oc_cc, :rep, :notes)
	end
end
