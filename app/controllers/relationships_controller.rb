class RelationshipsController < ApplicationController
	before_action :require_user, except: [:index]

	def index
		@relationships = current_user.following_relationships
	end

	def create
	end
end