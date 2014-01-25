class ForgotPasswordsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		if user
			AppMailer.send_forgot_password(user).deliver
			redirect_to forgot_password_confirmation_path
		else
		  flash[:error] = params[:email].blank? ? "Please specify an email address" : "The email address provided is not associated with a user"
		  redirect_to forgot_password_path
		end
	end

	def confirm
	end

end
