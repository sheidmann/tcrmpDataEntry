class UsersController < ApplicationController
	before_action :require_admin

	# Create a form for a new user
	def new
		@user = User.new
	end

	# Create a new user
	def create
		@user = User.new( user_params )
		# successful creation
		if @user.save
			redirect_to '/users', notice: "User successfully created"
		# Error occurred
		else
			redirect_to '/users', notice: "Error: user not created"
		end
	end

	# View all users
	def index
		@new_user = User.new # use in the view to render a form
		@all_users = User.order(created_at: :asc).all # use in the view to render a list of all posts
	end

	# Edit a user
	def edit
		@user = User.find(params[:id])
	end

	# Update the user
	def update
     @user = User.find(params[:id])
     # Successful update
     if @user.update(user_params)
       redirect_to '/users', notice: "User successfully updated"
     # An error occurred
     else
       render 'edit', notice: "Error: user not updated"
     end
   end

   # Delete a user
	def destroy 
	  @user = User.find(params[:id])
	  @user.destroy
	  # Successful deletion
	  if @user.destroy
        redirect_to '/users', notice: "User deleted"
	  # Error occurred
	  else
	  	redirect_to '/users', notice: "Error: user not deleted"
	  end
	end


	private

	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :agency, :active, :role)
	end
end
