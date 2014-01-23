class RelationshipsController < ApplicationController
	before_action :require_user, except: [:index]

	def index
		@relationships = current_user.following_relationships
	end

	def create
		leader = User.find(params[:leader_id])
		Relationship.create(leader_id: params[:leader_id], follower: current_user) unless current_user.following_relationships.map(&:leader).include?(leader) || leader == current_user
		redirect_to user_path(leader)
	end
end