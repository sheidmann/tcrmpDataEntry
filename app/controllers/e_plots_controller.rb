class EPlotsController < ApplicationController
	before_action :require_user

	# View all of a user's plots
	def index
    if @current_user.manager?
      @eps = EPlot.all
      @filename = "all"
    else
      @eps = @current_user.e_surveys.e_plots.all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @eps.as_csv, filename: "ECMP_Abiotic_#{@filename}_#{Date.today}.csv" }
    end
	end
end