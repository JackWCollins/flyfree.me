class VideosController < ApplicationController

  def new
  	@video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
    	flash[:notice] = "Your video was submitted!"
    	redirect_to root_path
    else
    	render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end
  
  private

  def video_params
  	params.require(:video).permit!
  end
end