require 'spec_helper'

describe Admin::VideosController do
	describe "GET index" do
		it_behaves_like "requires sign in" do
			let(:action) { get :index }
		end

		it "sets the @videos" do
			set_current_admin
			video = Fabricate(:video)
			get :index
			expect(assigns(:videos)).to eq([video])
		end

		it "redirects the regular user to the root path" do
			set_current_user
			get :index
			expect(response).to redirect_to root_path
		end

		it "sets the flash error message for the regular user" do
			set_current_user
			get :index
			expect(flash[:error]).to be_present
		end
	end

	describe "POST feature" do
		it_behaves_like "requires sign in" do
			let(:action) { get :index }
		end

		it "redirects the regular user to the root path" do
			set_current_user
			get :index
			expect(response).to redirect_to root_path
		end

		it "sets the flash error message for the regular user" do
			set_current_user
			get :index
			expect(flash[:error]).to be_present
		end

		it "sets the video as featured" do
			set_current_admin
			video = Fabricate(:video)
			post :feature, id: video.id
			expect(Video.first.featured).to be_true
		end

		it "redirects to the video page" do
			set_current_admin
			video = Fabricate(:video)
			post :feature, id: video.id
			expect(response).to redirect_to video
		end
	end
end