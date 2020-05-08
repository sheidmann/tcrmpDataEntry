class BoatlogsController < ApplicationController
	before_action :require_manager

	def new
		@boatlog = Boatlog.new
	end

	def index
		#@new_boatlog = Boatlog.new # use in the view to render a form
		if @current_user.role == 'admin'
    		@all_boatlogs = Boatlog.order(date_completed: :asc).all
    	elsif @current_user.role == 'manager'
    		#@boat_logs = BoatLog.where( "boatlog_manager_id=?", current_user.boatlog_manager_id )
    		@all_boatlogs = Boatlog.order(date_completed: :asc).all
    	end
	end

	def edit
		@boatlog = Boatlog.find(params[:id])
	end

	private

	def boatlog_params
		params.require(:boatlog).permit(:site, :date_completed, :time_begin, :manager_name)
	end
end
