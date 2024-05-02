class EEsaPasController < ApplicationController
	before_action :require_user

	# View all of a user's ECMP ESA presence/absence
	def index
    if @current_user.manager?
      @esas = EEsaPa.all
      @filename = "all"
    else
      @esas = @current_user.e_surveys.e_esa_pas.all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @esas.as_csv, filename: "ECMP_ESA_Presence_#{@filename}_#{Date.today}.csv" }
    end
	end
end