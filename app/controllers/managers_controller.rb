class ManagersController < ApplicationController
	before_action :require_admin

	# Create a form for a new manager
	def new
		@manager = Manager.new
	end

	# Create a new manager
	def create
		@manager = Manager.new( manager_params )
		# successful creation
		if @manager.save
			redirect_to '/managers', notice: "Manager successfully created"
		# Error occurred
		else
			redirect_to '/managers', notice: "Error: manager not created"
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
     # Successful update
     if @manager.update(manager_params)
       redirect_to '/managers', notice: "Manager successfully updated"
     # An error occurred
     else
       render 'edit', notice: "Error: manager not updated"
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
		params.require(:manager).permit(:manager_name, :project)
	end
end
