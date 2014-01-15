require 'spec_helper'

describe VideosController do
	describe "GET new" do
		it "sets the @video for authenticated users" do
			alice = Fabricate(:user)
			session[:user_id] = alice.id
			get :new
			expect(assigns(:video)).to be_instance_of(Video)
		end

		it "redirects unauthenticated users to the sign in page" do
			get :new
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "POST create" do
		context "for authenticated users" do

			context "with valid input" do

				it "creates the video" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: Fabricate.attributes_for(:video)
					expect(Video.count).to eq(1)
				end

				it "redirects to the root path" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: Fabricate.attributes_for(:video)
					expect(response).to redirect_to root_path
				end
				it "sets the current user in user_id" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: Fabricate.attributes_for(:video)
					expect(Video.first.user).to eq(alice)
				end
			end

			context "with invalid input" do 
				it "does not create the video" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: {title: "A title!", url: "www.google.com" }
					expect(Video.count).to eq(0)
				end
				it "renders the :new template" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: {title: "A title!", url: "www.google.com" }
					expect(response).to render_template :new
				end
				it "sets @video" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: {title: "A title!", url: "www.google.com" }
					expect(assigns(:video)).to be_instance_of(Video)
				end
			end
		end
		context "for unauthenticated users" do
			it "should redirect to the sign in path" do
				post :create, video: Fabricate.attributes_for(:video)
				expect(response).to redirect_to sign_in_path
			end
		end
	end
end