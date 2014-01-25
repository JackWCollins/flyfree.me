class VotesController < ApplicationController
	before_action :require_user

	def create
		@video = Video.find(params[:video_id])
		Vote.create(vote: params[:vote], user: current_user, video_id: @video.id)
		redirect_to root_path
	end
end