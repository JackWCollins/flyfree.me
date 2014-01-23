require 'spec_helper'

describe User do
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
end