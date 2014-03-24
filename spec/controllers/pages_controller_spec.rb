require 'spec_helper'

describe PagesController do
	describe "GET index" do
		it "gets the @featured_videos" do
			featured = Fabricate(:video, featured: true)
			standard = Fabricate(:video)
			get :index
			expect(assigns(:featured_videos)).to eq([featured])
		end
		it "gets the @standard_videos" do
			featured = Fabricate(:video, featured: true)
			standard = Fabricate(:video)
			get :index
			expect(assigns(:standard_videos)).to eq([standard])
		end
	end
end