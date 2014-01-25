class VotesController < ApplicationController
	before_action :require_user

	def create
		@video = Video.find(params[:video_id])
		@vote = Vote.create(vote: params[:vote], user: current_user, video_id: @video.id)

		respond_to do |format|
			format.html { redirect_to @video, notice: "Vote was counted" }
			format.js {}
		end
	end
end