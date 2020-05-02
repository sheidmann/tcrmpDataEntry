class UsersController < ApplicationController
	before_action :require_admin

	def new
		@user = User.new
	end

	def create
		attrs = user_params
    	attrs[ :name ] = attrs[ :name ].upcase(  )
    	attrs[ :username ] = attrs[ :name ].downcase(  )
    	attrs[ :password ] = attrs[ :name ].downcase(  )
		@user = User.new( attrs )
		if @user.save
			redirect_to '/manageuser', notice: "User successfully created"
		else
			redirect_to '/manageuser', notice: "Error: user not created"
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
       redirect_to '/manageuser', notice: "User successfully updated"
     else
       render 'edit', notice: "Error: user not updated"
     end
   end

	def destroy 
	  @user = User.find(params[:id])
	  @user.destroy
	  if @user.destroy
        redirect_to '/manageuser', notice: "User deleted"
	  else
	  	redirect_to '/manageuser', notice: "Error: user not deleted"
	  end
	end


	private

	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :agency, :active, :role)
	end
end
