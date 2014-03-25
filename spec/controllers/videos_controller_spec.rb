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
					post :create, video: {title: "A title!", url: "http://www.youtube.com/watch?v=pIZkgHMMSsM" }
					expect(Video.count).to eq(0)
				end
				it "renders the :new template" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: {title: "A title!", url: "http://www.youtube.com/watch?v=pIZkgHMMSsM" }
					expect(response).to render_template :new
				end
				it "sets @video" do
					alice = Fabricate(:user)
					session[:user_id] = alice.id
					post :create, video: {title: "A title!", url: "http://www.youtube.com/watch?v=pIZkgHMMSsM" }
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

	describe "GET show" do
		it "sets the @video" do
			video = Fabricate(:video)
			get :show, id: video.id
			expect(assigns(:video)).to eq(video)
		end
		it "sets the @reviews" do
			video = Fabricate(:video)
			review1 = Fabricate(:review, video: video)
			review2 = Fabricate(:review, video: video)
			get :show, id: video.id
			expect(assigns(:reviews)).to match_array([review1, review2])
		end
	end

	describe "GET featured" do
		it "sets the @featured_videos without requiring sign in" do
			vimeo = Fabricate(:video, featured: true)
			youtube = Fabricate(:video, featured: true)
			get 'featured'
			expect(assigns(:featured_videos)).to eq([youtube, vimeo])
		end
	end
end