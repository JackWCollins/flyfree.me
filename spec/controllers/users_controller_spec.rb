require 'spec_helper'

describe UsersController do 
	describe "GET new" do
		it "sets @user for new users" do
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end
	end

	describe "POST create" do
		context "with valid input" do
			before { post :create, user: Fabricate.attributes_for(:user) }

			it "creates the user" do
				expect(User.count).to eq(1)
			end

			it "puts the user in the session" do
				expect(session[:user_id]).not_to be_nil
			end

			it "redirects to root path" do
				expect(response).to redirect_to root_path
			end
		end

		context "with invalid input" do
			before { post :create, user: { password: "password", username: "Jack" } }

			it "does not create the user" do
				expect(User.count).to eq(0)
			end

			it "renders the :new template" do
				expect(response).to render_template :new
			end

			it "sets @user" do
				expect(assigns(:user)).to be_instance_of(User)
			end
		end

		context "sending emails" do
			after { ActionMailer::Base.deliveries.clear }

			it "sends out email to the user with valid inputs" do
				post :create, user: { email: "joe@example.com", password: "password", username: "JoeSkydive", full_name: "Joe Skydive" }
				expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
			end
			it "sends out email containing the user's username" do
				post :create, user: { email: "joe@example.com", password: "password", username: "JoeSkydive", full_name: "Joe Skydive" }
				expect(ActionMailer::Base.deliveries.last.body).to include("JoeSkydive")
			end
			it "does not send out email with invalid inputs" do
				post :create, user: { email: "joe@example.com", username: "JoeSkydive", full_name: "Joe Skydive" }
				expect(ActionMailer::Base.deliveries).to be_empty
			end
		end
	end
end