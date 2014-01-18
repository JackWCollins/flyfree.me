require 'spec_helper'

describe RelationshipsController do
	describe "GET index" do
		it "sets @relationships to the current user's following relationships" do
			alice = Fabricate(:user)
			set_current_user(alice)
			bob = Fabricate(:user)
			relationship = Fabricate(:relationship, follower: alice, leader: bob)
			get :index
			expect(assigns(:relationships)).to eq([relationship])
		end
	end

	describe "POST create" do
		it_behaves_like "requires sign in" do
			let(:action) { post :create, leader_id: 3 }
		end
	end
end