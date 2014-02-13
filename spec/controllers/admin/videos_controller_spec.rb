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
			expect(flash[:danger]).to be_present
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
			expect(flash[:danger]).to be_present
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

	describe "DELETE destroy" do
		it "redirects to the root path" do
			alice = Fabricate(:admin)
			set_current_admin(alice)
			video = Fabricate(:video)
			delete :destroy, id: video.id
			expect(response).to redirect_to root_path
		end
		it "deletes the video" do
			alice = Fabricate(:admin)
			set_current_admin(alice)
			video = Fabricate(:video)
			delete :destroy, id: video.id
			expect(Video.count).to eq(0)
		end
		it "sets the flash success message if the video is deleted" do
			alice = Fabricate(:admin)
			set_current_admin(alice)
			video = Fabricate(:video)
			delete :destroy, id: video.id
			expect(flash[:success]).to be_present
		end
		it "does not delete the video if the user is not an admin" do
			alice = Fabricate(:user)
			set_current_user(alice)
			video = Fabricate(:video)
			delete :destroy, id: video.id
			expect(Video.count).to eq(1)
		end
		it "sets the flash danger message if the video is not deleted" do
			alice = Fabricate(:user)
			set_current_user(alice)
			video = Fabricate(:video)
			delete :destroy, id: video.id
			expect(flash[:danger]).to be_present
		end
  end
end