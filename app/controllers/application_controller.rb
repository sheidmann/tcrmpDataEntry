class ApplicationController < ActionController::Base
	# make methods available
	helper_method :current_user, :require_user, :require_admin, :require_manager

	def current_user 
  		@current_user ||= User.find(session[:user_id]) if session[:user_id] 
	end 
	
	def require_user 
  		redirect_to '/login' unless current_user 
	end 

	def require_admin 
  		redirect_to '/' unless current_user && current_user.admin? 
	end

	def require_manager 
  		redirect_to '/' unless current_user && current_user.manager? 
	end
end
