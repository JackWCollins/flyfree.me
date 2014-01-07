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
			it "creates the user" do
				post :create, user: Fabricate.attributes_for(:user)
				expect(User.count).to eq(1)
			end

			it "redirects to root path" do
				post :create, user: Fabricate.attributes_for(:user)
				expect(response).to redirect_to root_path
			end

		end

		context "with invalid input"
	end
end