class AppMailer < ActionMailer::Base
	def send_welcome_email(user)
		@user = user
		mail to: user.email, from: "info@flyfree.me", subject: "Welcome to flyfree.me!"
	end
end