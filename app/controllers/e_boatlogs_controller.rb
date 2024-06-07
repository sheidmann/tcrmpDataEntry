class EBoatlogsController < ApplicationController
	before_action :require_manager

	# Create a new boatlog
	def new
		@eboatlog = EBoatlog.new
    @eboatlog.e_boatlog_teams.build

    respond_to do |format|
  		format.html # new.html.erb
  		format.json { render json: @eboatlog }
  	end
	end

	# Create a new boatlog
	def create
		@eboatlog = EBoatlog.new( e_boatlog_params )

		respond_to do |format|
		  # successful creation
      if @eboatlog.save
        format.html { redirect_to @eboatlog, notice: 'Boatlog successfully created.' }
        format.json { render json: @eboatlog, status: :created, location: @eboatlog }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @eboatlog.errors, status: :unprocessable_entity }
      end
    end
	end

	# View all boatlogs
	def index
		@new_eboatlog = EBoatlog.new # use in the view to render a form
		# Admin can view all boatlogs
		if @current_user.role == 'admin'
    	@all_eboatlogs = EBoatlog.order(date_completed: :desc, dod: :desc).all
    # Manager can only view their own boatlogs
    elsif @current_user.role == 'manager'
    	#@boat_logs = BoatLog.where( "boatlog_manager_id=?", current_user.boatlog_manager_id )
    	@all_eboatlogs = EBoatlog.order(date_completed: :desc, dod: :desc).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eboatlogs }
      format.csv { send_data @all_eboatlogs.as_csv, filename: "ECMP_Boatlogs_#{Date.today}.csv" }
    end
	end

	# View a boatlog
  def show
    @eboatlog = EBoatlog.find(params[:id])
    @eboatlog_teams = @eboatlog.e_boatlog_teams.order(team: :asc, role: :asc).all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eboatlog }
    end
	end

	# Edit a boatlog
	def edit
		@eboatlog = EBoatlog.find(params[:id])
	end

	# Update the boatlog
	def update
    @eboatlog = EBoatlog.find(params[:id])

    respond_to do |format|
		  # successful update
      if @eboatlog.update(e_boatlog_params)
        format.html { redirect_to @eboatlog, notice: 'Boatlog successfully updated.' }
        format.json { render json: @eboatlog, status: :created, location: @eboatlog }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @eboatlog.errors, status: :unprocessable_entity }
      end
    end
   end

  # Delete a boatlog
	def destroy 
	  @eboatlog = EBoatlog.find(params[:id])
	  #@eboatlog.destroy
	  # Successful deletion
	  if @eboatlog.destroy
      redirect_to '/e_boatlogs', notice: "Boatlog deleted"
	  # Error occurred
	  else
	  	redirect_to '/e_boatlogs', notice: "Error: boatlog not deleted"
	  end
	end

	private

	def e_boatlog_params
		params.require(:e_boatlog).permit(:fid, :date_completed, :captain, :dod, :latitude, :longitude, :time_in, :time_out, :depth_ft, :hss, :disease, :notes, 
			e_boatlog_teams_attributes: [:id, :team, :user_id, :role, :_destroy])
	end
end
