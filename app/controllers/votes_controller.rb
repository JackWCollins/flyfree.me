class VotesController < ApplicationController

	def create
		respond_to do |format|
			if logged_in?
				@video = Video.find(params[:video_id])
		    @vote = Vote.create(vote: params[:vote], user: current_user, video_id: @video.id)
			  format.html { redirect_to @video, notice: "Vote was counted" }
			  format.js {}
			else
				format.html { redirect_to sign_in_path }
				format.js {}
			end
		end
	end
end