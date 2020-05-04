class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by_username(params[:session][:username])
		case
		when @user && @user.active? && @user.authenticate(params[:session][:password])
	    	session[:user_id] = @user.id
	    	redirect_to '/userhome', notice: "Logged in successfully"
	    when !@user
	  		redirect_to '/login', notice: "Error: user does not exist"
		when @user && !@user.active?
			redirect_to '/login', notice: "Error: user exists but is inactive"
		else
	    	redirect_to '/login', notice: "Error: could not log in"
		end 
	end

	def destroy 
	  session[:user_id] = nil 
	  redirect_to '/' , notice: "Logged out successfully"
	end
end
