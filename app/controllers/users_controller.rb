class UsersController < ApplicationController
	before_action :require_admin

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to '/manageuser'
		else
			redirect_to '/manageuser'
		end
	end

	def index
		@new_user = User.new # use in the view to render a form
		@all_users = User.order(created_at: :asc).all # use in the view to render a list of all posts
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to '/manageuser'
     else
       render 'edit'
     end
   end

	def destroy 
	  @user = User.find(params[:id])
	  @user.destroy
	  if @user.destroy
        redirect_to '/manageuser'
	  else
	  	redirect_to '/manageuser'
	  end
	end


	private

	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :agency, :active, :role)
	end
end
