class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to '/'
		else
			redirect_to '/signup'
		end
	end

	def index
		@new_user = User.new # use in the view to render a form
		@all_users = User.order(created_at: :asc).all # use in the view to render a list of all posts
	end

	def edit
	end

	def destroy 
	  user[:id] = nil 
	  redirect_to '/manageuser' 
	end


	private

	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :agency, :active, :role)
	end
end
