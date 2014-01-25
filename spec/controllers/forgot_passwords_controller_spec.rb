require 'spec_helper'

describe ForgotPasswordsController do
	describe "POST create" do
		context "with blank input" do
			it "redirects to the forgot password page" do
				post :create, email: ''
				expect(response).to redirect_to forgot_password_path
			end
			it "shows an error message" do
				post :create, email: ''
				expect(flash[:error]).to eq("Please specify an email address")
			end
		end
		context "with existing email" do 
			it "redirects to the forgot password confirmation page" do
				Fabricate(:user, email: "jack@example.com")
				post :create, email: "jack@example.com"
				expect(response).to redirect_to forgot_password_confirmation_path
			end
			it "sends out an email to the email address provided" do
				Fabricate(:user, email: "jack@example.com")
				post :create, email: "jack@example.com"
				expect(ActionMailer::Base.deliveries.last.to).to eq(["jack@example.com"])
			end
		end
		context "with non-existent email" do
			it "redirects to the forgot password page" do
				post :create, email: "foo@example.com"
				expect(response).to redirect_to forgot_password_path
			end
			it "shows an error message" do
				post :create, email: "foo@example.com"
				expect(flash[:error]).to eq("The email address provided is not associated with a user")
			end
		end
	end
end