class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def index
  	@videos = Video.order(created_at: :desc).page(params[:page])
  end

  def feature
  	@video = Video.find(params[:id])
  	@video.update_column(:featured, true)
  	redirect_to @video
  end

  def destroy
    video = Video.find(params[:id])
    video.destroy
    flash[:success] = "The video was deleted"
    redirect_to root_path
  end

  private

  def require_admin
  	unless current_user.admin?
  		flash[:danger] = "You are not authorized to do that"
  		redirect_to root_path
  	end
  end
end