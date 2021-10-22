class DiademasController < ApplicationController
	before_action :require_user

	# View all of a user's diademas
	def index
    if @current_user.manager?
      @diademas = Diadema.all
      @filename = "all"
    else
      @diademas = @current_user.fish_transects.diademas.all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @diademas.as_csv, filename: "Diadema_#{@filename}_#{Date.today}.csv" }
    end
	end
end