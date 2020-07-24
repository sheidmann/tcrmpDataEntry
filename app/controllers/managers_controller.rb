class ManagersController < ApplicationController
	before_action :require_admin

	# Create a form for a new manager
	def new
		@manager = Manager.new

		respond_to do |format|
  		format.html # new.html.erb
  		format.json { render json: @manager }
  	end
	end

	# Create a new manager
	def create
		@manager = Manager.new( manager_params )

		respond_to do |format|
			# successful creation
			if @manager.save
				format.html { redirect_to "/managers", notice: 'Manager successfully created.' }
			# Error occurred
			else
				format.html { render action: "new", notice: "Error: manager not created" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
			end
		end
	end

	# View all managers
	def index
		@new_manager = Manager.new # use in the view to render a form
		@all_managers = Manager.order(created_at: :asc).all
	end

	# Edit a manager
	def edit
		@manager = Manager.find(params[:id])
	end

	# Update the manager
	def update
    @manager = Manager.find(params[:id])

    respond_to do |format|
	    # Successful update
	    if @manager.update(manager_params)
	      format.html { redirect_to "/managers", notice: 'Manager successfully updated.' }
	    # Otherwise, print errors
	    else
	      format.html { render action: "edit", notice: "Error: manager not updated" }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
	    end
	  end
   end

   # Delete a manager
	def destroy 
	  @manager = Manager.find(params[:id])
	  @manager.destroy
	  # Successful deletion
	  if @manager.destroy
      redirect_to '/managers', notice: "Manager deleted"
	  # Error occurred
	  else
	  	redirect_to '/managers', notice: "Error: manager not deleted"
	  end
	end

	private

	def manager_params
		params.require(:manager).permit(:project, :user_id)
	end
end
