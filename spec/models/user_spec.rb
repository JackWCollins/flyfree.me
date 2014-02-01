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
end