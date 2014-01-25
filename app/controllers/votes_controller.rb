class VotesController < ApplicationController
	before_action :require_user

	def create
		@video = Video.find(params[:video_id])
		Vote.create(vote: true, user: current_user)
		redirect_to root_path
	end
end