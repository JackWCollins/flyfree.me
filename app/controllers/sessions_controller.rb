class SessionsController < ApplicationController

	def new
		redirect_to root_path if current_user
	end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: "You are signed in. Enjoy!"
		else
			flash[:error] = "Invalid email address or password"
			redirect_to sign_in_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "You've signed out"
	end
end