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

	# View all of a user's fish transects
	def index
		@new_ftran = FishTransect.new # use in the view to render a form
		# Only show transects
		@ftrans = @current_user.fish_transects.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @fish_transect }
      #format.xlsx
    end
	end

	# View a fish transect
  def show
    @ftran = FishTransect.find(params[:id])
    @tranfs = @ftran.transect_fish.all
    @diademas = @ftran.diadema.all

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @fish_transect }
    end
	end

	private

	def fish_transect_params
		params.require(:fish_transect).permit(:manager_id, :site_id, :user_id, :date_completed, :begin_time, :rep, :completed_m, :notes, :oc_cc, transect_fishes_attributes: [:id, :fish_id, :x0to5, :x6to10, :x11to20, :x21to30, :x31to40, :xgt40, :_destroy])
	end
end
