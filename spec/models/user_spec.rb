require 'spec_helper'

describe User do
	it { should have_many(:votes) }

	it "generates a random token when user is created" do
		alice = Fabricate(:user)
		expect(alice.token).to be_present
	end

	describe "#follows?" do
		it "returns true if the user has a following relationship with another user" do
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: bob, follower: alice)
			expect(alice.follows?(bob)).to be_true
		end
		it "returns false if the user does not have a following relationship with another user" do
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: alice, follower: bob)
			expect(alice.follows?(bob)).to be_false
		end
	end

	describe "#can_feature?" do
		it "returns false if the user is not an admin" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			expect(alice.can_feature?(video)).to be_false
		end

		it "returns false if the video is already featured and the user is an admin" do
			video = Fabricate(:video, featured: true)
			alice = Fabricate(:admin)
			expect(alice.can_feature?(video)).to be_false
		end
		it "returns true if the user is an admin and the video is not featured" do
			video = Fabricate(:video)
			alice = Fabricate(:admin)
			expect(alice.can_feature?(video)).to be_true
		end
	end

	describe "#user_votes" do
		it "should return 0 if the user doesn't have any videos" do
			alice = Fabricate(:user)
			expect(alice.user_votes).to eq(0)
		end

		it "should return the total number of votes from ones video if the user has only one video" do
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			video = Fabricate(:video, user: alice)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: true)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			expect(alice.user_votes).to eq(2)
		end
		
		it "should return the total number of combined votes from all videos if the user has three videos" do
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			dan = Fabricate(:user)
			video = Fabricate(:video, user: alice)
			video2 = Fabricate(:video, user: alice)
			video3 = Fabricate(:video, user: alice)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: true)
			vote2 = Vote.create(video_id: video2.id, user_id: bob.id, vote: true)
			vote3 = Vote.create(video_id: video2.id, user_id: charlie.id, vote: true)
			vote3 = Vote.create(video_id: video3.id, user_id: dan.id, vote: true)
			expect(alice.user_votes).to eq(4)
		end
	end
end