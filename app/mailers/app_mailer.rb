class AppMailer < ActionMailer::Base
	def send_welcome_email(user)
		@user = user
		mail to: user.email, from: "info@flyfree.me", subject: "Welcome to flyfree.me!"
	end

	def send_forgot_password(user)
		@user = user
		mail to: user.email, from: "no-reply@flyfree.me", subject: "Password Reset from flyfree.me"
	end
end