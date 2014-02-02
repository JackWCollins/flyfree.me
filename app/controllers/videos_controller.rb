class VideosController < ApplicationController
  before_action :require_user, except: [:show, :featured]
  def new
  	@video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user = current_user
    @video.thumbnail_url = @video.get_thumbnail_url
    
    if @video.save
    	flash[:notice] = "Your video was submitted!"
    	redirect_to root_path
    else
    	render :new
    end
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def featured
    @videos = Video.featured.order(created_at: :desc).page(params[:page])
  end
  
  private

  def video_params
  	params.require(:video).permit!
  end
end