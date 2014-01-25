require 'spec_helper'

describe VotesController do
	describe "POST create" do
		context "for authenticated users" do
			let(:video) { Fabricate(:video) }
			let(:current_user) { Fabricate(:user) }
			before { session[:user_id] = current_user.id }

			it "should create a vote for an upvote" do
				post :create, vote: true, video_id: video.id
				expect(Video.first.votes).not_to be_nil
			end

			it "should create a vote for a downvote" do
				post :create, vote: false, video_id: video.id
				expect(Video.first.votes).not_to be_nil
			end
	  end

	  context "for unauthenticated users" do
	  	it "should redirect to the sign in path" do
	  		video = Fabricate(:video)
	  		post :create, vote: true, video_id: video.id
	  		expect(response).to redirect_to sign_in_path
	  	end
	  end
	end
end