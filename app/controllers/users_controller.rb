class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Thanks for registering!"
			redirect_to root_path
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:full_name, :password, :email, :username)
	end
end