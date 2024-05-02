class EPlotCoralsController < ApplicationController
	before_action :require_user

	# View all of a user's ECMP corals
	def index
    if @current_user.manager?
      @epcs = EPlotCoral.all
      @filename = "all"
    else
      @epcs = @current_user.e_surveys.e_plot_corals.all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @epcs.as_csv, filename: "ECMP_Coral_#{@filename}_#{Date.today}.csv" }
    end
	end
end