class SessionsController < ApplicationController
	def new
	end

	# Log in
	def create
		@user = User.find_by_username(params[:session][:username])
		case
		# valid login
		when @user && @user.active? && @user.authenticate(params[:session][:password])
	    	session[:user_id] = @user.id
	    	redirect_to '/userhome', notice: "Logged in successfully"
	    # user does not exist
	    when !@user
	  		redirect_to '/login', notice: "Error: user does not exist"
	  	# user exists but is inactive
		when @user && !@user.active?
			redirect_to '/login', notice: "Error: user exists but is inactive"
		# any other error
		else
	    	redirect_to '/login', notice: "Error: could not log in"
		end 
	end

	# Log out
	def destroy 
	  session[:user_id] = nil 
	  redirect_to '/' , notice: "Logged out successfully"
	end
end
