class PagesController < ApplicationController

  def index
  	@featured_videos = Video.featured.order(created_at: :desc).page(params[:page])
  	@standard_videos = Video.standard.order(created_at: :desc).page(params[:page])
  end

  def about
  end

  def contact
  end
end