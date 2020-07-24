class UsersController < ApplicationController
	before_action :require_admin

	# Create a form for a new user
	def new
		@user = User.new

		respond_to do |format|
  		format.html # new.html.erb
  		format.json { render json: @user }
  	end
	end

	# Create a new user
	def create
		@user = User.new( user_params )

		respond_to do |format|
			# successful creation
			if @user.save
				format.html { redirect_to "/users", notice: 'User successfully created.' }
			# Otherwise, print errors
			else
				format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# View all users
	def index
		#@new_user = User.new # use in the view to render a form
		@all_users = User.order(created_at: :asc).all # use in the view to render a list of all posts

		@users = User.export_columns 
		respond_to do |format|
			format.html # index.html.erb
			format.csv { send_data @users.as_csv }
		end
	end

	# Edit a user
	def edit
		@user = User.find(params[:id])
	end

	# Update the user
	def update
    @user = User.find(params[:id])

    respond_to do |format|
	    # Successful update
	    if @user.update(user_params)
	     format.html { redirect_to "/users", notice: 'User successfully updated.' }
	    # Otherwise, print errors
	    else
	      format.html { render action: "edit", notice: "Error: user not updated" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
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
