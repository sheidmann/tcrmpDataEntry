class BoatlogsController < ApplicationController
	before_action :require_manager

	# Create a new boatlog
	def new
		@boatlog = Boatlog.new
		# 2.times do
  #     		@boatlog.boatlog_surveys.build
  #     	end
	end

	# Create a new boatlog
	def create
		@boatlog = Boatlog.new( boatlog_params )

		# respond_to do |format|
	 #      if @boatlog.save
	 #        format.html { redirect_to @boatlog, notice: 'Boatlog successfully created.' }
	 #        format.json { render json: @boatlog, status: :created, location: @boatlog }
	 #      else
	 #        format.html { render action: "new" }
	 #        format.json { render json: @boatlog.errors, status: :unprocessable_entity }
	 #      end
	 #    end
		# successful creation
		if @boatlog.save
			redirect_to '/boatlogs', notice: "Boatlog successfully created"
		# Error occurred
		else
			redirect_to '/boatlogs', notice: "Error: boatlog not created"
		end
	end

	# View all boatlogs
	def index
		@new_boatlog = Boatlog.new # use in the view to render a form
		# Admin can view all boatlogs
		if @current_user.role == 'admin'
    		@all_boatlogs = Boatlog.order(date_completed: :asc).all
    	# Manager can only view their own boatlogs
    	elsif @current_user.role == 'manager'
    		#@boat_logs = BoatLog.where( "boatlog_manager_id=?", current_user.boatlog_manager_id )
    		@all_boatlogs = Boatlog.order(date_completed: :asc).all
    	end
	end

	def show
	    @boatlog = Boatlog.find(params[:id])

	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @boatlog }
	    end
	end

	# Edit a boatlog
	def edit
		@boatlog = Boatlog.find(params[:id])
	end

	# Update the boatlog
	def update
     @boatlog = Boatlog.find(params[:id])
     # Successful update
     if @boatlog.update(boatlog_params)
       redirect_to '/boatlogs', notice: "Boatlog successfully updated"
     # An error occurred
     else
       render 'edit', notice: "Error: boatlog not updated"
     end
   end

   # Delete a boatlog
	def destroy 
	  @boatlog = Boatlog.find(params[:id])
	  @boatlog.destroy
	  # Successful deletion
	  if @boatlog.destroy
        redirect_to '/boatlogs', notice: "Boatlog deleted"
	  # Error occurred
	  else
	  	redirect_to '/boatlogs', notice: "Error: boatlog not deleted"
	  end
	end

	private

	def boatlog_params
		params.require(:boatlog).permit(:site, :date_completed, :begin_time, :manager_id, boatlog_surveys_attributes: [:id, :user_id, :survey_type_id, :rep, :_destroy])
	end
end